//
//  SP.swift
//  MusicImport
//
//  Created by crypto_user on 10.03.2020.
//  Copyright © 2020 Данил Войдилов. All rights reserved.
//

import Foundation
import SwiftHttp
import VDCodable
@_exported import SwiftMusicServicesApi

public enum Spotify {

    ///https://developer.spotify.com/documentation/web-api/
    ///https://developer.spotify.com/documentation/ios/quick-start/
    public final class API: HttpCodablePipelineCollection {
        
        public static var baseURL = HttpUrl(host: "api.spotify.com", path: ["v1"])

        public var client: HttpClient
        public var baseURL: HttpUrl
        public var token: String?

        public init(client: HttpClient, baseURL: HttpUrl = API.baseURL, token: String? = nil) {
            self.client = client
            self.baseURL = baseURL
            self.token = token
        }

        public func encoder<T: Encodable>() -> HttpRequestEncoder<T> {
            HttpRequestEncoder(encoder: VDJSONEncoder())
        }

        public func decoder<T: Decodable>() -> HttpResponseDecoder<T> {
            let decoder = VDJSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase(separators: CharacterSet(charactersIn: "_"))
            decoder.dateDecodingStrategy = .iso8601
            return HttpResponseDecoder(decoder: decoder)
        }

        public func headers(with additionalHeaders: [HttpHeaderKey: String] = [:], auth: Bool = true) throws -> [HttpHeaderKey: String] {
            if auth {
                guard let token else {
                    throw SPError(status: 401, message: "Token is missed")
                }
                return additionalHeaders.merging([.authorization: "Bearer \(token)"]) { _, s in s }
            } else {
                return additionalHeaders
            }
        }
    }
}
