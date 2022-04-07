//
//  BaseRequests.swift
//  YandexAPI
//
//  Created by Daniil on 08.11.2019.
//  Copyright © 2019 Daniil. All rights reserved.
//

import Foundation
import SwiftHttp
import VDCodable
@_exported import SwiftMusicServicesApi

public typealias YM = Yandex.Music
public typealias YMO = Yandex.Music.Objects

public enum Yandex {
	public enum Music {}
}

extension Yandex.Music {
	public enum Objects {}

	public struct API: HttpCodablePipelineCollection {
		public static let baseURL = HttpUrl(host: "api.music.yandex.net")
		public static let authURL = HttpUrl(host: "oauth.yandex.ru")
		public static let passportURL = HttpUrl(host: "passport.yandex.com")
		public static let mobileproxyPassportURL = HttpUrl(host: "mobileproxy.passport.yandex.net")
		public static var uuid = UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: "")
		public static var ifv = UUID()

		public var client: HttpClient
		public var token: String?
		public var queryEncoder: URLQueryEncoder
		public var baseURL: HttpUrl

		public init(client: HttpClient, token: String? = nil, baseURL: HttpUrl = API.baseURL) {
			self.client = client
			self.token = token
			self.baseURL = baseURL
			let encoder = URLQueryEncoder()
			encoder.nestedEncodingStrategy = .json
			encoder.trimmingSquareBrackets = true
			queryEncoder = encoder
		}

		public func encoder<T: Encodable>() -> HttpRequestEncoder<T> {
			HttpRequestEncoder(encoder: VDJSONEncoder())
		}

		public func decoder<T: Decodable>() -> HttpResponseDecoder<T> {
			HttpResponseDecoder(decoder: YandexDecoder())
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
		public func request<U: Decodable>(
				url: HttpUrl,
				method: HttpMethod,
				auth: Bool = true,
				body: Data? = nil,
				headers: [HttpHeaderKey: String] = [:],
				validators: [HttpResponseValidator] = [HttpStatusCodeValidator()]
		) async throws -> U {
			if auth {
				let result: YMO.Result<U> = try await decodableRequest(
						executor: client.dataTask,
						url: url,
						method: method,
						body: body,
						headers: self.headers(with: headers, auth: auth),
						validators: validators
				)
				return result.result
			} else {
				let result: U = try await decodableRequest(
						executor: client.dataTask,
						url: url,
						method: method,
						body: body,
						headers: self.headers(with: headers, auth: auth),
						validators: validators
				)
				return result
			}
		}

		///
		/// Executes a raw request pipeline using a data values as a body and returns the response
		///
		/// - Parameter url: The url to send the request
		/// - Parameter method: The request method
		/// - Parameter auth: The request requires authentication
		/// - Parameter headers: The request headers
		/// - Parameter body: The request body as a `Encodable` value
		/// - Parameter validators: The response validators
		///
		/// - Throws: `Error` if something was wrong
		///
		/// - Returns: The decoded response object
		///
		public func request<I: Encodable, U: Decodable>(
				url: HttpUrl,
				method: HttpMethod = .post,
				auth: Bool = true,
				body: I,
				headers: [HttpHeaderKey: String] = [:],
				validators: [HttpResponseValidator] = [HttpStatusCodeValidator()]
		) async throws -> U {
			if auth {
				let result: YMO.Result<U> = try await codableRequest(
						executor: client.dataTask,
						url: url,
						method: method,
						headers: self.headers(with: headers, auth: auth),
						body: body,
						validators: validators
				)
				return result.result
			} else {
				let result: U = try await codableRequest(
						executor: client.dataTask,
						url: url,
						method: method,
						headers: self.headers(with: headers, auth: auth),
						body: body,
						validators: validators
				)
				return result
			}
		}

		public func headers(with additionalHeaders: [HttpHeaderKey: String] = [:], auth: Bool = true) -> [HttpHeaderKey: String] {
			var headers: [HttpHeaderKey: String] = [
				.key(.userAgent): "Yandex-Music-API",
				.custom("X-Yandex-Music-Client"): "Yandex.Music/493"
			]
			if auth, let token = token {
				headers[.key(.authorization)] = "OAuth \(token)"
			}
			return additionalHeaders.merging(headers) { _, s in
				s
			}
		}

		public static func url(coverUri: String?) -> HttpUrl? {
			guard let uri = coverUri else {
				return nil
			}
			return HttpUrl(string: "https://" + uri.replacingOccurrences(of: "%%", with: "200x200"))
		}
	}
}