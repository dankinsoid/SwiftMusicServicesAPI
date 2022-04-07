//
//  AuthorisationRequest.swift
//  YandexAPI
//
//  Created by Daniil on 08.11.2019.
//  Copyright © 2019 Daniil. All rights reserved.
//

import Foundation
import SwiftHttp
import VDCodable

extension Yandex.Music.API {
	
	public func token(input: TokenInput) async throws -> TokenOutput {
		try await request(
				url: Yandex.Music.API.authURL.path("token"),
				method: .post,
				auth: false,
				body: Data(URLQueryEncoder(keyEncodingStrategy: .convertToSnakeCase).encodePath(input).utf8)
		)
	}

	public struct TokenInput: Codable {
		public var clientId: String
		public var clientSecret: String
		public var username: String
		public var password: String
		public var grantType: GrantType = .password

		public init(clientId: String, clientSecret: String, username: String, password: String, grantType: GrantType = .password) {
			self.clientId = clientId
			self.clientSecret = clientSecret
			self.username = username
			self.password = password
			self.grantType = grantType
		}
	}

	public struct TokenOutput: Decodable {
		public let tokenType: String?   //"bearer"
		public let accessToken: String
		public let expiresIn: Int?
		public let uid: Int?
	}
	
	public enum GrantType: String, Codable {
		case password, authorization_code, sessionid, x_token = "x-token"
	}
}
