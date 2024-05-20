import Foundation
import SwiftHttp
import SwiftAPIClient
@_exported import SwiftMusicServicesApi
import VDCodable

public struct VK {

	public final class API {
		public static var baseURL = HttpUrl(host: "m.vk.com", trailingSlashEnabled: false)

		public var client: HttpClient
		public var baseURL: HttpUrl
		public var webCookies: [String: String] = [:]
        public var encoder = MultipartFormDataEncoder()
		private let pipeline = Pipeline()

		public init(client: HttpClient, baseURL: HttpUrl = API.baseURL, webCookies: [String: String] = [:]) {
			self.client = client.rateLimit()
			self.baseURL = baseURL
			self.webCookies = webCookies
		}

		public func decoder<T: Decodable>() -> HttpResponseDecoder<T> {
			HttpResponseDecoder(decoder: VDJSONDecoder())
		}

		public func headers(with additional: [HttpHeaderKey: String] = [:], multipart: Bool = false, minimum: Bool = false, cookie: Bool = true) -> [HttpHeaderKey: String] {
			var defaultHeaders: [HttpHeaderKey: String] = [
                .contentType: multipart ? encoder.contentType.rawValue : "application/x-www-form-urlencoded",
			]
			if !minimum {
				defaultHeaders.merge([
					.accept: "*/*",
					"Origin": baseURL.url.absoluteString,
					.acceptLanguage: "ru-RU,ru;q=0.9,en-US;q=0.8,en;q=0.7",
					.userAgent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36 OPR/105.0.0.0",
					.xRequestedWith: "XMLHttpRequest",
				]) { _, s in
					s
				}
			}

			if cookie, !webCookies.isEmpty {
				defaultHeaders["Cookie"] = webCookies.map { "\($0.key)=\($0.value)" }.joined(separator: "; ")
			}
			return defaultHeaders.merging(additional) { _, s in s }
		}

		///
		/// Executes a raw request pipeline using a data values as a body and returns the response
		///
		/// - Parameter url: The url to send the request
		/// - Parameter method: The request method
		/// - Parameter auth: The request requires authentication
		/// - Parameter headers: The request headers
		/// - Parameter body: The request body as a data value
		/// - Parameter validators: The response validators
		///
		/// - Throws: `Error` if something was wrong
		///
		/// - Returns: The decoded response object
		///
		public func request<U: HTMLStringInitable>(
			url: HttpUrl,
			method: HttpMethod,
			auth _: Bool = true,
			body: Data? = nil,
			headers: [HttpHeaderKey: String] = [:],
			minimum: Bool = false,
			validators: [HttpResponseValidator] = [HttpStatusCodeValidator()]
		) async throws -> U {
			try await APIFailure.wrap(url: url, method: method) {
				let response = try await pipeline.rawRequest(
					executor: client.dataTask,
					url: url,
					method: method,
					headers: self.headers(with: headers, minimum: minimum),
					body: body,
					validators: validators
				)
				let string: String
				do {
					string = try JSONDecoder().decode(VKPage.self, from: response.data).html
				} catch {
					string = String(data: response.data, encoding: .utf8) ?? ""
				}
				return try U(htmlString: string)
			}
		}

        public func urlEncoded(_ body: some Encodable) throws -> Data {
            let params = try URLQueryEncoder().encodeParameters(body)
            return params.map { "\($0.key)=\($0.value)" }.joined(separator: "&").data(using: .utf8) ?? Data()
        }
        
		public func multipartData(_ body: some Encodable) throws -> Data {
            try encoder.encode(body)
		}

		public func rawRequest(
			url: HttpUrl,
			method: HttpMethod,
			headers: [HttpHeaderKey: String],
			body: Data? = nil,
			validators: [HttpResponseValidator] = [HttpStatusCodeValidator()]
		) async throws -> HttpResponse {
			try await APIFailure.wrap(url: url, method: method) {
                try await pipeline.rawRequest(executor: client.dataTask, url: url, method: method, headers: headers, body: body, validators: validators)
			}
		}

		public func encodableRequest(
			url: HttpUrl,
			method: HttpMethod,
			headers: [HttpHeaderKey: String],
			body: some Encodable,
			validators: [HttpResponseValidator] = [HttpStatusCodeValidator()]
		) async throws -> HttpResponse {
			try await APIFailure.wrap(url: url, method: method) {
                try await pipeline.encodableRequest(executor: client.dataTask, url: url, method: method, headers: headers, body: body, validators: validators)
			}
		}

		public func decodableRequest<U: Decodable>(
			url: HttpUrl,
			method: HttpMethod,
			body: Data? = nil,
			headers: [HttpHeaderKey: String],
			validators: [HttpResponseValidator] = [HttpStatusCodeValidator()]
		) async throws -> U {
			try await APIFailure.wrap(url: url, method: method) {
                try await pipeline.decodableRequest(executor: client.dataTask, url: url, method: method, body: body, headers: headers, validators: validators)
			}
		}

		public func codableRequest<U: Decodable>(
			url: HttpUrl,
			method: HttpMethod,
			headers: [HttpHeaderKey: String],
			body: some Encodable,
			validators: [HttpResponseValidator] = [HttpStatusCodeValidator()]
		) async throws -> U {
			try await APIFailure.wrap(url: url, method: method) {
				try await pipeline.codableRequest(executor: client.dataTask, url: url, method: method, headers: headers, body: body, validators: validators)
			}
		}

		private struct Pipeline: HttpCodablePipelineCollection {

			func decoder<T: Decodable>() -> HttpResponseDecoder<T> {
				HttpResponseDecoder(decoder: VDJSONDecoder())
			}
		}
	}
}

public extension VK {
	enum Objects {}
}
