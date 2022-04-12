//
// Created by Данил Войдилов on 11.04.2022.
//

import Foundation
import SwiftHttp
import VDCodable
@_exported import SwiftMusicServicesApi

public enum AppleMusic {

	public struct API: HttpCodablePipelineCollection {
		public static var baseURL = HttpUrl(host: "api.music.apple.com").path("v1")
		public var client: HttpClient
		public var baseURL: HttpUrl
		public var token: AppleMusic.Objects.Tokens?
		public var userToken: String?

		public init(client: HttpClient, baseURL: HttpUrl = API.baseURL, token: AppleMusic.Objects.Tokens? = nil) {
			self.client = client
			self.baseURL = baseURL
			self.token = token
		}

		public func encoder<T: Encodable>() -> HttpRequestEncoder<T> {
			HttpRequestEncoder(encoder: VDJSONEncoder())
		}

		public func decoder<T: Decodable>() -> HttpResponseDecoder<T> {
			HttpResponseDecoder(decoder: VDJSONDecoder())
		}

		public func headers(with additionalHeaders: [HttpHeaderKey: String] = [:], auth: Bool = true) -> [HttpHeaderKey: String] {
			var result: [HttpHeaderKey: String] = additionalHeaders
			if auth, let token = token {
				result[.key(.authorization)] = "Bearer \(token.token)"
				result[.custom("Music-User-Token")] = token.userToken
			}
			return result
		}
	}
}