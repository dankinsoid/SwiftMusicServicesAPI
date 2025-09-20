import Foundation
import SwiftAPIClient
@_exported import SwiftMusicServicesApi

extension Amazon.Music {

	public final class BrowserAPI: @unchecked Sendable {

		public static let baseURL = URL(string: "https://music.amazon.com")!
		public static let requiredAuthCookies: Set<String> = ["at-main", "sess-at-main", "session-id", "session-token", "ubid-main", "x-main"]
		public var client: APIClient
		private let lock = ReadWriteLock()

		public var webCookies: [String: String] {
			get {
				lock.withReaderLock { _webCookies }
			}
			set {
				lock.withWriterLockVoid {
					_webCookies = newValue
				}
				Task {
					try await cache.save(newValue, for: .cookies)
				}
			}
		}

		public var userAgent: String {
			get {
				lock.withReaderLock { _userAgent }
			}
			set {
				lock.withWriterLockVoid {
					_userAgent = newValue
				}
				Task {
					try await cache.save(newValue, for: .userAgent)
				}
			}
		}

		var config: Amazon.Objects.Config? {
			get {
				lock.withReaderLock { _config }
			}
			set {
				lock.withWriterLockVoid {
					_config = newValue
					_configDate = Date()
				}
			}
		}

		var isConfigExpired: Bool {
			let configDate = lock.withReaderLock { _configDate }
			guard let configDate, let config else { return true }
			let expiresIn = config.accessTokenExpiresIn.flatMap { TimeInterval($0) } ?? 0
			return Date().timeIntervalSince(configDate) > expiresIn - 60 // 1 minute before expiration
		}

		public let cache: SecureCacheService
		private var _webCookies: [String: String] = [:]
		private var _userAgent = defaultUserAgent
		private var _config: Amazon.Objects.Config?
		private var _configDate: Date?

		public init(
			client: APIClient = APIClient(),
			cache: SecureCacheService,
			webCookies: [String: String] = [:]
		) {
			_webCookies = webCookies
			self.cache = cache
			self.client = client

			self.client = client
				.url(Self.baseURL)
				.httpResponseValidator(.statusCode)
				.auth(enabled: true)
				.redirect(behaviour: .doNotFollow)
				.auth(
					AuthModifier { [weak self] components in
						components.headers[.cookie] = (self?.webCookies ?? webCookies)
							.map { "\($0.key)=\($0.value)" }
							.joined(separator: "; ")
					}
				)
				.httpClientMiddleware(SetCookiesMiddleware(api: self))

			Task { [self] in
				userAgent = await (try? cache.load(for: .userAgent)) ?? defaultUserAgent
				self.webCookies = await ((try? cache.load(for: .cookies) as [String: String]?) ?? [:]).merging(webCookies) { _, n in n }
			}
		}

		public var musicClient: APIClient {
			client.url("https://na.mesk.skill.music.a2z.com/api")
				.httpClientMiddleware(BodyMiddleware(api: self))
		}
	}

	private struct BodyMiddleware: HTTPClientMiddleware {

		weak var api: Amazon.Music.BrowserAPI?

		func execute<T>(
			request: HTTPRequestComponents,
			configs: APIClient.Configs,
			next: @escaping (HTTPRequestComponents, APIClient.Configs) async throws -> (T, HTTPResponse)
		) async throws -> (T, HTTPResponse) {
			var request = request
			if let api, request.method != .get, request.body == nil, configs.isAuthEnabled {
				let config = try await api.congif()
				var body = try Amazon.Objects.DefaultBody(
					headers: Amazon.Objects.Headers(
						accessToken: config.accessToken,
						csrf: config.csrf,
						xAmznDeviceId: config.deviceId,
						xAmznUserAgent: api.userAgent,
						xAmznSessionId: config.sessionId
					)
				)
				try configs.amazonBody(&body, configs)
				request.body = try .data(configs.bodyEncoder.encode(body))
				request.headers.append(.contentType(.application(.json)))
				request.headers.append(.contentEncoding("gzip"))
			}
			return try await next(request, configs)
		}
	}

	private struct SetCookiesMiddleware: HTTPClientMiddleware {

		weak var api: Amazon.Music.BrowserAPI?

		func execute<T>(
			request: HTTPRequestComponents,
			configs: APIClient.Configs,
			next: @escaping (HTTPRequestComponents, APIClient.Configs) async throws -> (T, HTTPResponse)
		) async throws -> (T, HTTPResponse) {
			let (value, resp) = try await next(request, configs)
			if let setCookie = resp.headerFields[.setCookie] {
				api?.webCookies.merge(parseSetCookieHeader(setCookie)) { _, new in new }
			}
			return (value, resp)
		}
	}
}

private func parseSetCookieHeader(_ header: String) -> [String: String] {
	var result: [String: String] = [:]
	var current = ""

	// Pattern: name=value (value can be anything except ;)
	let nameValueRegex = try! NSRegularExpression(pattern: #"^([^=;]+)=([^;]*)"#, options: [])

	// Pattern: ends with Expires=..., which can contain commas
	let expiresRegex = try! NSRegularExpression(pattern: #"(?i)expires\s*=\s*[^;]+$"#)

	for part in header.split(separator: ",", omittingEmptySubsequences: false) {
		let trimmed = part.trimmingCharacters(in: .whitespaces)
		current += current.isEmpty ? trimmed : ", " + trimmed

		let currentRange = NSRange(current.startIndex ..< current.endIndex, in: current)

		if expiresRegex.firstMatch(in: current, options: [], range: currentRange) != nil {
			continue // still in Expires=...
		}

		if let match = nameValueRegex.firstMatch(in: current, options: [], range: currentRange),
		   match.numberOfRanges == 3,
		   let nameRange = Range(match.range(at: 1), in: current),
		   let valueRange = Range(match.range(at: 2), in: current)
		{
			let name = String(current[nameRange])
			let value = String(current[valueRange])
			result[name] = value
			current = ""
		}
	}

	// Final piece if any
	if !current.isEmpty {
		let currentRange = NSRange(current.startIndex ..< current.endIndex, in: current)
		if let match = nameValueRegex.firstMatch(in: current, options: [], range: currentRange),
		   match.numberOfRanges == 3,
		   let nameRange = Range(match.range(at: 1), in: current),
		   let valueRange = Range(match.range(at: 2), in: current)
		{
			let name = String(current[nameRange])
			let value = String(current[valueRange])
			result[name] = value
		}
	}

	return result
}

public extension APIClient.Configs {

	var amazonBody: (inout Amazon.Objects.DefaultBody, APIClient.Configs) throws -> Void {
		get { self[\.amazonBody] ?? { _, _ in } }
		set { self[\.amazonBody] = newValue }
	}
}

public extension APIClient {

	func amazonBody(
		_ body: @escaping (inout Amazon.Objects.DefaultBody, APIClient.Configs) throws -> Void
	) -> APIClient {
		configs { configs in
			let current = configs.amazonBody
			configs.amazonBody = {
				try current(&$0, $1)
				try body(&$0, $1)
			}
		}
	}
}
