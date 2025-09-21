import Foundation
import SwiftAPIClient

public struct SPTokenResponse: Codable {

	public enum CodingKeys: String, CodingKey, CaseIterable {

		case accessToken
		case expiresIn
		case refreshToken
		case scope
		case tokenType
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

extension SPTokenResponse: Mockable {
	public static let mock = SPTokenResponse(
		accessToken: "mock_access_token_123",
		expiresIn: 3600,
		refreshToken: "mock_refresh_token_123",
		tokenType: "Bearer",
		scope: "user-read-private user-read-email"
	)
}
