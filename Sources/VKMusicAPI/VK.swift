import Foundation
import MultipartFormDataKit
import SwiftHttp
@_exported import SwiftMusicServicesApi
import VDCodable

public struct VK {

	public final class API {
		public static var baseURL = HttpUrl(host: "m.vk.com", trailingSlashEnabled: false)

		public var client: HttpClient
		public var baseURL: HttpUrl
		public var webCookies: [String: String] = [:]
		public var boundary = "boundary." + RandomBoundaryGenerator.generate()
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
				.contentType: multipart ? "multipart/form-data; boundary=\(boundary)" : "application/x-www-form-urlencoded",
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
		public func htmlRequest<U: HTMLStringInitable>(
			url: HttpUrl,
			method: HttpMethod,
			auth _: Bool = true,
			body: Data? = nil,
			headers: [HttpHeaderKey: String] = [:],
			minimum: Bool = false,
			validators: [HttpResponseValidator] = []
		) async throws -> U {
			try await request(
				url: url,
				method: method,
				headers: self.headers(with: headers, minimum: minimum),
				body: body,
				validators: validators
			) { data in
				let string: String
				do {
					string = try JSONDecoder().decode(VKPage.self, from: data).html
				} catch {
					string = String(data: data, encoding: .utf8) ?? ""
				}
				return try U(htmlString: string)
			}
		}

		public func urlEncoded(_ body: some Encodable) throws -> Data {
			let params = try URLQueryEncoder().encodeParameters(body)
			return params.map { "\($0.key)=\($0.value)" }.joined(separator: "&").data(using: .utf8) ?? Data()
		}

		public func multipartData(_ body: some Encodable) throws -> Data {
			let params = try URLQueryEncoder().encodeParameters(body)
			return try MultipartFormData.Builder.build(
				with: params.map {
					(
						name: $0.key,
						filename: nil,
						mimeType: nil,
						data: $0.value.data(using: .utf8) ?? Data()
					)
				},
				willSeparateBy: boundary
			).body
		}

		public func request<T>(
			url: HttpUrl,
			method: HttpMethod,
			headers: [HttpHeaderKey: String],
			body: Data? = nil,
			validators: [HttpResponseValidator] = [],
			decode: (Data) throws -> T
		) async throws -> T {
			try await APIFailure.wrap(url: url, method: method) {
				try await checkRedirect(url: url) {
					try await pipeline.rawRequest(
						executor: client.dataTask,
						url: url,
						method: method,
						headers: headers,
						body: body,
						validators: validators
					)
				} decode: {
					try decode($0.data)
				}
			}
		}

		private func checkRedirect<T>(
			url: HttpUrl,
			request: () async throws -> HttpResponse,
			decode: (HttpResponse) throws -> T
		) async throws -> T {
			let response = try await request()
			setCookies(response: response, httpUrl: url)
			do {
				return try decode(response)
			} catch {
				throw error
				try await checkRedirect(url: url, response: response)
				return try await decode(request())
			}
		}

		private func checkRedirect(
			url: HttpUrl,
			response: HttpResponse,
			lastLocation: HttpUrl? = nil
		) async throws {
			setCookies(response: response, httpUrl: url)
			let json: JSON? = try? decoder().decode(response.data)
			guard
				let locationString = json?["location"]?.string,
				var location = HttpUrl(
					string: locationString.hasPrefix("http") ? locationString : [baseURL.url.absoluteString, locationString].map {
						$0.trimmingCharacters(in: ["/"])
					}
					.joined(separator: "/")
				)
			else {
				print("Location not found")
				return
			}
			location.isTrailingSlashEnabled = false
			print("================================================================")
			print(location)
			guard lastLocation != location else {
				print("Location is equal to last location")
				return
			}
			let redirectResponse = try await pipeline.rawRequest(
				executor: client.dataTask,
				url: location,
				method: .get,
				headers: headers(
					with: [
						.accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
					]
				)
			)
			try await checkRedirect(url: location, response: redirectResponse, lastLocation: location)
		}

		private func setCookies(response: HttpResponse, httpUrl: HttpUrl) {
			let cookies = HTTPCookie.cookies(
				withResponseHeaderFields: Dictionary(uniqueKeysWithValues: response.headers.map { ($0.key.rawValue, $0.value) }),
				for: httpUrl.url
			)
			cookies.forEach {
				webCookies[$0.name] = $0.value
			}
			print(webCookies)
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
