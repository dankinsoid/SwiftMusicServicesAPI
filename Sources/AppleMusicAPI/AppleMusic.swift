import Foundation
import SwiftHttp
@_exported import SwiftMusicServicesApi

public enum AppleMusic {
    
	public final class API: HttpCodablePipelineCollection {
        
        public static var baseURL = HttpUrl(host: "api.music.apple.com", trailingSlashEnabled: false)
		public var client: HttpClient
		public var baseURL: HttpUrl
		public var token: AppleMusic.Objects.Tokens?
		public var userToken: String?

		public init(client: HttpClient, baseURL: HttpUrl = API.baseURL, token: AppleMusic.Objects.Tokens? = nil) {
			self.client = client.rateLimit(errorCodes: [.tooManyRequests, .forbidden])
			self.baseURL = baseURL
			self.token = token
		}

		public func encoder<T: Encodable>() -> HttpRequestEncoder<T> {
			HttpRequestEncoder(encoder: JSONEncoder())
		}

		public func decoder<T: Decodable>() -> HttpResponseDecoder<T> {
			HttpResponseDecoder(decoder: JSONDecoder())
		}

		public func headers(with additionalHeaders: [HttpHeaderKey: String] = [:], auth: Bool = true) -> [HttpHeaderKey: String] {
			var result: [HttpHeaderKey: String] = additionalHeaders
			if auth, let token {
				result[.authorization] = "Bearer \(token.token)"
				result["Music-User-Token"] = token.userToken
			}
			return result
		}
	}
}
