import Foundation
import SwiftHttp
import VDCodable

public extension Yandex.Music.API {
	func passportToken(clientId: String, clientSecret: String, accessToken: String, _yasc: String, info: TokenBySessionIDQuery) async throws -> Yandex.Music.API.TokenOutput {
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
				.contentType: "application/x-www-form-urlencoded",
				"Cookie": "_yasc=\(_yasc)",
				"Host": "mobileproxy.passport.yandex.net",
			]
		)
	}

	struct PassportTokenInput: Codable {
		public var client_id: String
		public var client_secret: String
		public var grant_type: YM.API.GrantType = .x_token
		public var access_token: String
		public var payment_auth_retpath = "yandexmusic://am/payment_auth"
	}
}
