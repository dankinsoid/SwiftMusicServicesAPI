import Foundation
import SwiftAPIClient

public extension Amazon {

	struct API: @unchecked Sendable {

		public static let baseURL = URL(string: "https://api.amazon.com/")!

		public let client: APIClient
		public let cache: SecureCacheService

		public init(
			client: APIClient = APIClient(),
			clientID: String,
			clientSecret: String,
			redirectURI: String,
			cache: SecureCacheService
		) {
			self.client = client.amazon(
				baseURL: Self.baseURL,
				clientID: clientID,
				clientSecret: clientSecret,
				redirectURI: redirectURI,
				cache: cache
			)
			self.cache = cache
		}

		public init(
			client: APIClient,
			clientID: String,
			clientSecret: String,
			redirectURI: String,
			accessToken: String? = nil,
			refreshToken: String? = nil,
			expiryAt: Date? = nil
		) {
			self.init(
				client: client,
				clientID: clientID,
				clientSecret: clientSecret,
				redirectURI: redirectURI,
				cache: MockSecureCacheService([
					.accessToken: accessToken,
					.refreshToken: refreshToken,
					.expiryDate: expiryAt.map(DateFormatter.secureCacheService.string),
				].compactMapValues { $0 })
			)
		}

		public func update(accessToken: String, refreshToken: String, expiresIn: Double?) async {
			try? await cache.save(accessToken, for: .accessToken)
			try? await cache.save(refreshToken, for: .refreshToken)
			try? await cache.save(expiresIn.map { Date(timeIntervalSinceNow: $0) }, for: .expiryDate)
		}
	}
}

public extension APIClient {

	func amazon(
		baseURL: URL,
		clientID: String,
		clientSecret: String,
		redirectURI: String,
		cache: SecureCacheService
	) -> APIClient {
		url(baseURL)
			.tokenRefresher(cacheService: cache) { _, _, _ in
				let token = try await Amazon.Auth(
					client: self,
					clientID: clientID,
					clientSecret: clientSecret,
					redirectURI: redirectURI
				)
				.refreshToken(cache: cache)
				return (token.access_token, token.refresh_token, Date(timeIntervalSinceNow: token.expires_in))
			} auth: { token in
				.bearer(token: token)
			}
			.errorDecoder(.decodable(Amazon.Objects.Error.self))
	}
}
