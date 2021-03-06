//
//  VK.swift
//  
//
//  Created by Данил Войдилов on 08.04.2022.
//

import Foundation
import SwiftHttp
import MultipartFormDataKit
import  VDCodable
@_exported import SwiftMusicServicesApi

public struct VK {
	public final class API: HttpCodablePipelineCollection {
		public static var baseURL = HttpUrl(host: "m.vk.com")
		
		public var client: HttpClient
		public var baseURL: HttpUrl
		public var webCookies: [String: String] = [:]
		public var boundary = "boundary." + RandomBoundaryGenerator.generate()
		
		public init(client: HttpClient, baseURL: HttpUrl = API.baseURL, webCookies: [String: String] = [:]) {
			self.client = client
			self.baseURL = baseURL
			self.webCookies = webCookies
		}

		public func decoder<T: Decodable>() -> HttpResponseDecoder<T> {
			HttpResponseDecoder(decoder: VDJSONDecoder())
		}

		public func headers(with additional: [HttpHeaderKey: String] = [:], multipart: Bool = false, minimum: Bool = false, cookie: Bool = true) -> [HttpHeaderKey: String] {
			var defaultHeaders: [HttpHeaderKey: String] = [
				.contentType: multipart ? "multipart/form-data; boundary=\(boundary)" : "application/x-www-form-urlencoded"
			]
			if !minimum {
				defaultHeaders.merge([
					.accept: "*/*",
					"Origin": baseURL.url.absoluteString,
					.acceptLanguage: "ru-RU;q=1.0, en-RU;q=0.9",
					.userAgent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.1 Safari/605.1.15"
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
				auth: Bool = true,
				body: Data? = nil,
				headers: [HttpHeaderKey: String] = [:],
				minimum: Bool = false,
				validators: [HttpResponseValidator] = [HttpStatusCodeValidator()]
		) async throws -> U {
			let response = try await rawRequest(
					executor: client.dataTask,
					url: url,
					method: method,
					headers: self.headers(with: headers, minimum: minimum),
					body: body,
					validators: validators
			)
			let string = String(data: response.data, encoding: .utf8) ?? ""
			return try U(htmlString: string)
		}

		public func multipartData<B: Encodable>(_ body: B) throws -> Data {
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
	}
}

extension VK {
	public enum Objects {}
}

private struct VKPage: Codable {
	var html: String
}
