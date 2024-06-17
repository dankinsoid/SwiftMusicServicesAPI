import Foundation
import SwiftAPIClient

public extension Yandex.Music.API {

	func token(input: TokenInput) async throws -> TokenOutput {
        try await client.url(Yandex.Music.API.authURL)
            .path("token")
            .auth(enabled: false)
            .bodyDecoder(YandexDecoder(isAuthorized: false))
            .bodyEncoder(.formURL(keyEncodingStrategy: .convertToSnakeCase))
            .body(input)
            .post()
	}

	struct TokenInput: Codable {

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

	struct TokenOutput: Decodable {

		public let tokenType: String? // "bearer"
		public let accessToken: String
		public let expiresIn: Int?
		public let uid: Int?
	}

	enum GrantType: String, Codable, CaseIterable {

		case password, authorization_code, sessionid, x_token = "x-token", unknown

		public init(from decoder: Decoder) throws {
			self = try Self(rawValue: String(from: decoder)) ?? .unknown
		}
	}
}
