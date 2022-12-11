import Foundation
import SwiftHttp
import SimpleCoders
import VDCodable

public extension Yandex.Music.API {
	func token(input: TokenInput) async throws -> TokenOutput {
		try await request(
			url: Yandex.Music.API.authURL.path("token"),
			method: .post,
			auth: false,
			body: Data(
                URLQueryEncoder(keyEncodingStrategy: .convertToSnakeCase())
                    .encodePath(input)
                    .utf8
            )
		)
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
		case password, authorization_code, sessionid, x_token = "x-token"
	}
}
