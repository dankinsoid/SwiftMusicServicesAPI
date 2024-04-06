import Foundation
import SwiftAPIClient

public struct OAuthToken: Codable, Equatable {

	/** One of `authorization_code`, `client_credentials`, `refresh_token` */
	public var grantType: GrantType
	/** Client ID */
	public var clientId: String
	/** Client secret */
	public var clientSecret: String
	/** Authorization code. Required on `grant_type = authorization_code`. */
	public var code: String?
	/** Redirect URI. Required on `grant_type = (authorization_code|refresh_token)`. */
	public var redirectUri: String?
	/** Refresh token. Required on `grant_type = refresh_token`. */
	public var refreshToken: String?

	public enum CodingKeys: String, CodingKey {

		case grantType = "grant_type"
		case clientId = "client_id"
		case clientSecret = "client_secret"
		case code
		case redirectUri = "redirect_uri"
		case refreshToken = "refresh_token"
	}

	public init(
		grantType: GrantType,
		clientId: String,
		clientSecret: String,
		code: String? = nil,
		redirectUri: String? = nil,
		refreshToken: String? = nil
	) {
		self.grantType = grantType
		self.clientId = clientId
		self.clientSecret = clientSecret
		self.code = code
		self.redirectUri = redirectUri
		self.refreshToken = refreshToken
	}

	/** One of `authorization_code`, `client_credentials`, `refresh_token` */
	public enum GrantType: String, Codable, Equatable, CaseIterable, CustomStringConvertible {
		case authorizationCode = "authorization_code"
		case refreshToken = "refresh_token"
		case clientCredentials = "client_credentials"
		case undecoded

		public init(from decoder: Decoder) throws {
			let container = try decoder.singleValueContainer()
			let rawValue = try container.decode(String.self)
			self = GrantType(rawValue: rawValue) ?? .undecoded
		}

		public var description: String { rawValue }
	}
}
