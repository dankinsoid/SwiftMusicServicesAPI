import Foundation
import SwiftHttp
@_exported import SwiftMusicServicesApi

public enum AppleMusic {

	public final class API {

		public static var baseURL = HttpUrl(host: "api.music.apple.com", trailingSlashEnabled: false)
		public var client: HttpClient
		public var baseURL: HttpUrl
		public var token: AppleMusic.Objects.Tokens?
		public var userToken: String?
		private let pipeline = Pipeline()

		public init(client: HttpClient, baseURL: HttpUrl = API.baseURL, token: AppleMusic.Objects.Tokens? = nil) {
			self.client = client.rateLimit(errorCodes: [.tooManyRequests, .forbidden])
			self.baseURL = baseURL
			self.token = token
		}

		public func headers(with additionalHeaders: [HttpHeaderKey: String] = [:], auth: Bool = true) -> [HttpHeaderKey: String] {
			var result: [HttpHeaderKey: String] = additionalHeaders
			if auth, let token {
				result[.authorization] = "Bearer \(token.token)"
				result["Music-User-Token"] = token.userToken
			}
			return result
		}

		func encodableRequest(
			url: HttpUrl,
			method: HttpMethod,
			headers: [HttpHeaderKey: String] = [:],
			body: some Encodable,
			validators: [HttpResponseValidator] = [HttpStatusCodeValidator()]
		) async throws -> HttpResponse {
			try await APIFailure.wrap(url: url, method: method) {
				try await pipeline.encodableRequest(
					executor: client.dataTask,
					url: url,
					method: method,
					body: body,
					validators: validators
				)
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
				try await pipeline.decodableRequest(
					executor: client.dataTask,
					url: url,
					method: method,
					body: body,
					validators: validators
				)
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
				try await pipeline.codableRequest(
					executor: client.dataTask,
					url: url,
					method: method,
					body: body,
					validators: validators
				)
			}
		}

		private struct Pipeline: HttpCodablePipelineCollection {

			func encoder<T: Encodable>() -> HttpRequestEncoder<T> {
				HttpRequestEncoder(encoder: JSONEncoder())
			}

			func decoder<T: Decodable>() -> HttpResponseDecoder<T> {
				HttpResponseDecoder(decoder: JSONDecoder())
			}
		}
	}
}
