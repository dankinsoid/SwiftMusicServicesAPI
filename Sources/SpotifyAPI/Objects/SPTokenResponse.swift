import Foundation

public struct SPTokenResponse: Codable {

	public enum CodingKeys: String, CodingKey, CaseIterable {

		case accessToken = "access_token"
		case expiresIn = "expires_in"
		case refreshToken = "refresh_token"
		case scope
		case tokenType = "token_type"
	}

	public var accessToken: String
	public var expiresIn: Double
	public var refreshToken: String?
	public var tokenType: String?
	public var scope: String?

	public init(
		accessToken: String,
		expiresIn: Double,
		refreshToken: String? = nil,
		tokenType: String? = nil,
		scope: String? = nil
	) {
		self.accessToken = accessToken
		self.expiresIn = expiresIn
		self.refreshToken = refreshToken
		self.tokenType = tokenType
		self.scope = scope
	}
}
