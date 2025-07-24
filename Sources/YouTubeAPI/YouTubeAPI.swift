import Foundation
import SwiftAPIClient
@_exported import SwiftMusicServicesApi

public enum YouTube {
	public enum Objects {}
}

public typealias YT = YouTube
public typealias YTO = YouTube.Objects

public extension YouTube {

	struct API {

		public let client: APIClient
		public let cache: SecureCacheService

		public init(
			client: APIClient = APIClient(),
			clientID: String,
			clientSecret: String,
			redirectURI: String,
			apiKey: String,
			cache: SecureCacheService
		) {
			self.client = client.url("https://www.googleapis.com/youtube/v3")
				.tokenRefresher(cacheService: cache) { refreshToken, _, _ in
					let result = try await YouTube.OAuth2(
						client: client,
						clientID: clientID,
						clientSecret: clientSecret,
						redirectURI: redirectURI
					)
					.refreshToken(
						refreshToken.unwrap(throwing: TokenNotFound(name: "refreshToken"))
					)
					return (result.accessToken, refreshToken, Date(timeIntervalSinceNow: result.expiresIn))
				} auth: { token in
					.bearer(token: token)
				}
				.bodyEncoder(.json(dateEncodingStrategy: .iso8601))
				.bodyDecoder(.json(dateDecodingStrategy: .youtube))
				.queryEncoder(.urlQuery(arrayEncodingStrategy: .commaSeparator))
				.auth(enabled: true)
				.errorDecoder(.decodable(YTO.ErrorResponse.self))
				.httpResponseValidator(.statusCode)
				.modifyRequest { components, _ in
					if let key = HTTPField.Name("x-goog-api-key") {
						components.headers[key] = apiKey
					}
				}
				.logMaskedHeaders([HTTPField.Name("x-goog-api-key")!])
			self.cache = cache
		}

		public init(
			client: APIClient,
			clientID: String,
			clientSecret: String,
			redirectURI: String,
			apiKey: String,
			token: String? = nil,
			refreshToken: String? = nil,
			expiryAt: Date? = nil
		) {
			let cache = MockSecureCacheService([
				.accessToken: token,
				.refreshToken: refreshToken,
				.expiryDate: expiryAt.map(DateFormatter.secureCacheService.string),
			].compactMapValues { $0 })

			self.init(
				client: client,
				clientID: clientID,
				clientSecret: clientSecret,
				redirectURI: redirectURI,
				apiKey: apiKey,
				cache: cache
			)
		}

		public func update(accessToken: String, refreshToken: String?, expiresIn: Double?) async {
			try? await cache.save(accessToken, for: .accessToken)
			try? await cache.save(refreshToken, for: .refreshToken)
			try? await cache.save(expiresIn.map { Date(timeIntervalSinceNow: $0) }, for: .expiryDate)
		}
	}
}

extension JSONDecoder.DateDecodingStrategy {

	static let youtube: JSONDecoder.DateDecodingStrategy = .custom { decoder in
		let container = try decoder.singleValueContainer()
		let dateString = try container.decode(String.self)

		let formats = [
			"yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ",
			"yyyy-MM-dd'T'HH:mm:ss.SSSZ",
			"yyyy-MM-dd'T'HH:mm:ssZ",
		]

		let formatter = DateFormatter()
		formatter.locale = Locale(identifier: "en_US_POSIX")
		formatter.timeZone = TimeZone(secondsFromGMT: 0)

		for format in formats {
			formatter.dateFormat = format
			if let date = formatter.date(from: dateString) {
				return date
			}
		}

		throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date format: \(dateString)")
	}
}
