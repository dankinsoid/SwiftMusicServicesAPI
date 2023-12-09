import Foundation
import SwiftHttp
@_exported import SwiftMusicServicesApi
import VDCodable

public enum Spotify {

	/// https://developer.spotify.com/documentation/web-api/
	/// https://developer.spotify.com/documentation/ios/quick-start/
	public final actor API {

		public static var apiBaseURL = HttpUrl(host: "accounts.spotify.com", path: ["api"])
		public static var v1BaseURL = HttpUrl(host: "api.spotify.com", path: ["v1"])

		var client: HttpClient
		public nonisolated var apiBaseURL: HttpUrl { API.apiBaseURL }
		public nonisolated var v1BaseURL: HttpUrl { API.v1BaseURL }
		public var token: String?
		public var refreshToken: String?
		public nonisolated let clientID: String
		public nonisolated let clientSecret: String
		private let pipeline = Pipeline()

		private var refreshTokenTask: Task<Void, Error>?

		public init(
			client: HttpClient,
			clientID: String,
			clientSecret: String,
			token: String? = nil,
			refreshToken: String? = nil
		) {
			self.client = client.rateLimit(timeout: 30)
			self.clientID = clientID
			self.clientSecret = clientSecret
			self.token = token
			self.refreshToken = refreshToken
		}

		public func headers(with additionalHeaders: [HttpHeaderKey: String] = [:], auth: AuthHeadersType? = .token) throws -> [HttpHeaderKey: String] {
			switch auth {
			case .token:
				guard let token else {
					throw SPError(status: 401, message: "Token is missed")
				}
				return additionalHeaders.merging([.authorization: "Bearer \(token)"]) { _, s in s }
			case .clientBase64:
				guard
					let authString = "\(clientID):\(clientSecret)"
					.data(using: .ascii)?
					.base64EncodedString(options: .endLineWithLineFeed)
				else {
					throw SPError(status: 401, message: "ClientID or ClientSecret is invalid")
				}
				return additionalHeaders.merging([.authorization: "Bearer \(authString)"]) { _, s in s }
            case .basic:
                let basic = "Basic \(Data("\(clientID):\(clientSecret)".utf8).base64EncodedString())"
                return additionalHeaders.merging([.authorization: basic]) { _, s in s }
			case .none:
				return additionalHeaders
			}
		}

		public func update(accessToken: String, refreshToken: String) async {
			try? await refreshTokenTask?.value
			token = accessToken
			self.refreshToken = refreshToken
		}

		public func encodableRequest(
			url: HttpUrl,
			method: HttpMethod,
			headers: [HttpHeaderKey: String] = [:],
			body: some Encodable,
			validators: [HttpResponseValidator] = [HttpStatusCodeValidator()]
		) async throws -> HttpResponse {
			try await APIFailure.wrap(url: url, method: method) {
				try await pipeline.encodableRequest(executor: dataTask, url: url, method: method, body: body, validators: validators)
			}
		}

		public func decodableRequest<U: Decodable>(
			url: HttpUrl,
			method: HttpMethod,
			body: Data? = nil,
			headers: [HttpHeaderKey: String] = [:],
			validators: [HttpResponseValidator] = [HttpStatusCodeValidator()]
		) async throws -> U {
			try await APIFailure.wrap(url: url, method: method) {
				try await pipeline.decodableRequest(executor: dataTask, url: url, method: method, body: body, validators: validators)
			}
		}

		public func codableRequest<U: Decodable>(
			url: HttpUrl,
			method: HttpMethod,
			headers: [HttpHeaderKey: String] = [:],
			body: some Encodable,
			validators: [HttpResponseValidator] = [HttpStatusCodeValidator()]
		) async throws -> U {
			try await APIFailure.wrap(url: url, method: method) {
				try await pipeline.codableRequest(executor: dataTask, url: url, method: method, body: body, validators: validators)
			}
		}

		private func dataTask(_ req: HttpRequest) async throws -> HttpResponse {
			try await refreshTokenTask?.value
			var response = try await client.dataTask(req)
			if response.statusCode == .unauthorized {
				do {
					refreshTokenTask = Task { [weak self] in
						try await self?.refreshToken()
					}
					try await refreshTokenTask?.value
					refreshTokenTask = nil
				} catch {
					throw SPError(status: response.statusCode.rawValue, message: "Token is invalid")
				}
				response = try await client.dataTask(req)
			}
			return response
		}

		private struct Pipeline: HttpCodablePipelineCollection {

			func encoder<T: Encodable>() -> HttpRequestEncoder<T> {
				HttpRequestEncoder(encoder: JSONEncoder())
			}

			func decoder<T: Decodable>() -> HttpResponseDecoder<T> {
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				decoder.dateDecodingStrategy = .iso8601
				return HttpResponseDecoder(
					decoder: decoder.decodeError(SPError.self)
				)
			}
		}
	}
}

public extension Spotify.API {

	enum AuthHeadersType: String, Codable {

		case token, clientBase64, basic
	}
}
