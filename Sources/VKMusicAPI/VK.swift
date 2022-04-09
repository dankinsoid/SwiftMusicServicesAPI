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
	public struct API: HttpCodablePipelineCollection {
		public static var baseURL = HttpUrl(host: "m.vk.com")
		
		public var client: HttpClient
		public var baseURL: HttpUrl
		public var webCookies: [String: String] = [:]
		
		public init(client: HttpClient, baseURL: HttpUrl = API.baseURL, webCookies: [String: String] = [:]) {
			self.client = client
			self.baseURL = baseURL
			self.webCookies = webCookies
		}

		public func decoder<T: Decodable>() -> HttpResponseDecoder<T> {
			HttpResponseDecoder(decoder: VDJSONDecoder())
		}

		public func headers(with additional: [HttpHeaderKey: String] = [:]) -> [HttpHeaderKey: String] {
			let defaultHeaders: [HttpHeaderKey: String] = [
				.key(.contentType): "application/x-www-form-urlencoded",
				.key(.accept): "*/*",
				.custom("Origin"): baseURL.url.absoluteString,
				.key(.userAgent): "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.1 Safari/605.1.15",
				.custom("X-Requested-With"): "XMLHttpRequest"
			].merging(webCookies.map { (.custom($0.key), $0.value) }) { _, s in s }
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
				validators: [HttpResponseValidator] = [HttpStatusCodeValidator()]
		) async throws -> U {
			let response = try await rawRequest(
					executor: client.dataTask,
					url: url,
					method: method,
					headers: self.headers(with: headers),
					body: body,
					validators: validators
			)
			guard let string = String(data: response.data, encoding: .utf8) else {
				throw HttpError.invalidResponse
			}
			return try U(htmlString: string)
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
		public func multiPartRequest<U: HTMLStringInitable, I: Encodable>(
				url: HttpUrl,
				method: HttpMethod,
				auth: Bool = true,
				body: I,
				headers: [HttpHeaderKey: String] = [:],
				validators: [HttpResponseValidator] = [HttpStatusCodeValidator()]
		) async throws -> U {
			let response = try await rawRequest(
					executor: client.dataTask,
					url: url,
					method: method,
					headers: self.headers(with: headers),
					body: multipartData(body),
					validators: validators
			)
			guard let string = String(data: response.data, encoding: .utf8) else {
				throw HttpError.invalidResponse
			}
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
							willSeparateBy: RandomBoundaryGenerator.generate()
					).body
		}
	}
}

extension VK {
	public enum Objects {}
}
