import Foundation
import SwiftAPIClient
@_exported import SwiftMusicServicesApi

extension Amazon.Music {
	
	public final class BrwoserAPI {
		
		public static let baseURL = URL(string: "https://music.amazon.com")!
		public static let requiredAuthCookies: Set<String> = ["at-main", "sess-at-main", "session-id", "session-token", "ubid-main", "x-main"]
		private(set) public var client: APIClient
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

		public var config: Amazon.Objects.Config? {
			get {
				lock.withReaderLock { _config }
			}
			set {
				lock.withWriterLockVoid {
					_config = newValue
				}
			}
		}

		public let cache: SecureCacheService
		private var _webCookies: [String: String] = [:]
		private var _userAgent = defaultUserAgent
		private var _config: Amazon.Objects.Config?

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
				userAgent = (try? await cache.load(for: .userAgent)) ?? defaultUserAgent
				self.webCookies = ((try? await cache.load(for: .cookies) as [String: String]?) ?? [:]).merging(webCookies) { _, n in n }
			}
		}
	}

	private struct SetCookiesMiddleware: HTTPClientMiddleware {

		weak var api: Amazon.Music.BrwoserAPI?

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

				let currentRange = NSRange(current.startIndex..<current.endIndex, in: current)

				if expiresRegex.firstMatch(in: current, options: [], range: currentRange) != nil {
						continue // still in Expires=...
				}

				if let match = nameValueRegex.firstMatch(in: current, options: [], range: currentRange),
					 match.numberOfRanges == 3,
					 let nameRange = Range(match.range(at: 1), in: current),
					 let valueRange = Range(match.range(at: 2), in: current) {
						let name = String(current[nameRange])
						let value = String(current[valueRange])
						result[name] = value
						current = ""
				}
		}

		// Final piece if any
		if !current.isEmpty {
				let currentRange = NSRange(current.startIndex..<current.endIndex, in: current)
				if let match = nameValueRegex.firstMatch(in: current, options: [], range: currentRange),
					 match.numberOfRanges == 3,
					 let nameRange = Range(match.range(at: 1), in: current),
					 let valueRange = Range(match.range(at: 2), in: current) {
						let name = String(current[nameRange])
						let value = String(current[valueRange])
						result[name] = value
				}
		}

		return result
}
