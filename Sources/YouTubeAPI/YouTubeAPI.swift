import Foundation
import SwiftMusicServicesApi
import SwiftAPIClient

public enum YouTube {
    public enum Objects {}
}

public typealias YT = YouTube
public typealias YTO = YouTube.Objects

extension YouTube {

    public struct API {

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
                        refreshToken.unwrap(throwing: AnyError("No refresh token found in cache"))
                    )
                    return (result.accessToken, refreshToken, Date(timeIntervalSinceNow: result.expiresIn))
                } auth: { token in
                    .bearer(token: token)
                }
                .bodyEncoder(.json(dateEncodingStrategy: .iso8601))
                .bodyDecoder(.json(dateDecodingStrategy: .iso8601))
                .queryEncoder(.urlQuery(arrayEncodingStrategy: .commaSeparator))
                .auth(enabled: true)
                .errorDecoder(.decodable(YTO.ErrorResponse.self))
                .httpResponseValidator(.statusCode)
                .modifyRequest { components, configs in
                    if let key = HTTPField.Name("x-goog-api-key") {
                        components.headers[key] = apiKey
                    }
                }
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
            expiryIn: Double? = nil
        ) {
            let cache = MockSecureCacheService([
                .accessToken: token,
                .refreshToken: refreshToken,
            ].compactMapValues { $0 })
            
            self.init(
                client: client,
                clientID: clientID,
                clientSecret: clientSecret,
                redirectURI: redirectURI,
                apiKey: apiKey,
                cache: cache
            )
            if let expiryIn {
                Task {
                    try await cache.save(Date(timeIntervalSinceNow: expiryIn), for: .expiryDate)
                }
            }
        }

        public func update(accessToken: String, refreshToken: String?, expiresIn: Double?) async {
            try? await cache.save(accessToken, for: .accessToken)
            try? await cache.save(refreshToken, for: .refreshToken)
            try? await cache.save(expiresIn.map { Date(timeIntervalSinceNow: $0) }, for: .expiryDate)
        }
    }
}
