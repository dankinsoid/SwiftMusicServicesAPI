//
//  YMToken.swift
//  MusicImport
//
//  Created by Данил Войдилов on 21.03.2022.
//  Copyright © 2022 Данил Войдилов. All rights reserved.
//

import Foundation
import SwiftHttp
import VDCodable

extension Yandex.Music.API {
	
	public func passportToken(clientId: String, clientSecret: String, accessToken: String, _yasc: String, info: TokenBySessionIDQuery) async throws -> Yandex.Music.API.TokenOutput {
		let input = PassportTokenInput(client_id: clientId, client_secret: clientSecret, access_token: accessToken)

		let encoder = URLQueryEncoder(keyEncodingStrategy: .convertToSnakeCase)
		encoder.nestedEncodingStrategy = .json
		encoder.trimmingSquareBrackets = true

		return try await request(
				url: Yandex.Music.API.mobileproxyPassportURL.path("1", "token").query(from: info, encoder: encoder),
				method: .post,
				auth: false,
				body: Data(encoder.encodePath(input).utf8),
				headers: [
					.key(.contentType): "application/x-www-form-urlencoded",
					.custom("Cookie"): "_yasc=\(_yasc)",
					.custom("Host"): "mobileproxy.passport.yandex.net"
				]
		)
	}

	public struct PassportTokenInput: Codable {
		public var client_id: String
		public var client_secret: String
		public var grant_type: YM.API.GrantType = .x_token
		public var access_token: String
		public var payment_auth_retpath	= "yandexmusic://am/payment_auth"
	}
}
