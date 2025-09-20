import Foundation
import SwiftAPIClient
import SwiftMusicServicesApi

public extension Amazon.Music {

	struct DeviceAPI {

		public static let baseURL = URL(string: "https://music-api.amazon.com/")!

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
