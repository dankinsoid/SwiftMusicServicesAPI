import Foundation
import SwiftHttp
@_exported import SwiftMusicServicesApi
import VDCodable

public enum Spotify {

	/// https://developer.spotify.com/documentation/web-api/
	/// https://developer.spotify.com/documentation/ios/quick-start/
	public final class API: HttpCodablePipelineCollection {

		public static var apiBaseURL = HttpUrl(host: "accounts.spotify.com", path: ["api"])
		public static var v1BaseURL =  HttpUrl(host: "api.spotify.com", path: ["v1"])

		public var client: HttpClient
		public var apiBaseURL: HttpUrl
		public var v1BaseURL: HttpUrl
		public var token: String?
		public var refreshToken: String?
		public var clientID: String
		public var clientSecret: String
		private var refreshTokenTask: Task<Void, Error>?

		public init(
			client: HttpClient,
			apiBaseURL: HttpUrl = API.apiBaseURL,
			v1BaseURL: HttpUrl = API.v1BaseURL,
			clientID: String,
			clientSecret: String,
			token: String? = nil,
			refreshToken: String? = nil
		) {
			self.client = client.rateLimit(timeout: 30)
			self.v1BaseURL = v1BaseURL
			self.apiBaseURL = apiBaseURL
			self.clientID = clientID
			self.clientSecret = clientSecret
			self.token = token
			self.refreshToken = refreshToken
		}

		public func encoder<T: Encodable>() -> HttpRequestEncoder<T> {
			HttpRequestEncoder(
				encoder: VDJSONEncoder()
			)
		}

		public func decoder<T: Decodable>() -> HttpResponseDecoder<T> {
			let decoder = VDJSONDecoder()
			decoder.keyDecodingStrategy = .convertFromSnakeCase(separators: CharacterSet(charactersIn: "_"))
			decoder.dateDecodingStrategy = .iso8601
			return HttpResponseDecoder(
				decoder: decoder.decodeError(SPError.self)
			)
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
			case .none:
				return additionalHeaders
			}
		}

		func dataTask(_ req: HttpRequest) async throws -> HttpResponse {
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
	}
}

extension Spotify.API {

	public enum AuthHeadersType: String, Codable {
		
		case token, clientBase64
	}
}
