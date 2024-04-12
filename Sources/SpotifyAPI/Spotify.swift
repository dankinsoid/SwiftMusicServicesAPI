import Foundation
import SwiftAPIClient
@_exported import SwiftMusicServicesApi

public enum Spotify {

	/// https://developer.spotify.com/documentation/web-api/
	/// https://developer.spotify.com/documentation/ios/quick-start/
	public final class API {

		public static var apiBaseURL = URL(string: "https://accounts.spotify.com/api")!
		public static var v1BaseURL = URL(string: "https://api.spotify.com/v1")!

        public let clientWithoutTokenRefresher: APIClient
		public var apiBaseURL: URL { API.apiBaseURL }
		public var v1BaseURL: URL { API.v1BaseURL }
		public let clientID: String
		public let clientSecret: String
        public let cache = MockSecureCacheService()

		public init(
			client: APIClient,
			clientID: String,
			clientSecret: String,
			token: String? = nil,
			refreshToken: String? = nil
		) {
            clientWithoutTokenRefresher = client
                .url(Self.v1BaseURL)
                .bodyDecoder(.json(dateDecodingStrategy: .iso8601, keyDecodingStrategy: .convertFromSnakeCase))
                .errorDecoder(.decodable(SPError.self))
                .auth(enabled: true)
                .httpResponseValidator(.statusCode)
			self.clientID = clientID
			self.clientSecret = clientSecret
		}

        public var client: APIClient {
            clientWithoutTokenRefresher
                .tokenRefresher(cacheService: cache) { [clientID, clientSecret] refreshToken, client, _ in
                    try await Self.refreshToken(
                        client: client,
                        refreshToken: refreshToken,
                        clientID: clientID,
                        clientSecret: clientSecret
                    )
                } auth: {
                    .bearer(token: $0)
                }
        }

        public var base64Auth: AuthModifier {
            AuthModifier { [clientID, clientSecret] req, _ in
                guard
                    let authString = "\(clientID):\(clientSecret)"
                        .data(using: .ascii)?
                        .base64EncodedString(options: .endLineWithLineFeed)
                else {
                    throw SPError(status: 401, message: "ClientID or ClientSecret is invalid")
                }
                req.headers.append(.authorization(bearerToken: authString))
            }
        }

        public var basicAuth: AuthModifier {
            .basic(username: clientID, password: clientSecret)
        }

        public func update(accessToken: String, refreshToken: String, expiresIn: Double?) async {
            try? await cache.save(accessToken, for: .accessToken)
            try? await cache.save(refreshToken, for: .refreshToken)
            try? await cache.save(expiresIn.map { Date(timeIntervalSinceNow: $0) }, for: .expiryDate)
		}
	}
}

private extension SecureCacheServiceKey {
    
    static let code: Self = "code"
}

private extension Spotify.API {

    /// https://developer.spotify.com/documentation/general/guides/authorization/code-flow/
    static func refreshToken(
        client: APIClient,
        refreshToken: String?,
        clientID: String,
        clientSecret: String
    ) async throws -> (accessToken: String, refreshToken: String?, expiryDate: Date?) {
        guard let refreshToken else {
            throw SPError(status: 401, message: "No refresh token")
        }
        let response: SPTokenResponse = try await client
            .url(apiBaseURL)
            .path("token")
            .bodyEncoder(.formURL)
            .body([
                "grant_type": "refresh_token",
                "refresh_token": refreshToken,
            ])
            .headers(.accept(""), removeCurrent: true)
            .auth(.basic(username: clientID, password: clientSecret))
            .post()
        return (response.accessToken, response.refreshToken, Date(timeIntervalSinceNow: response.expiresIn))
    }
}
