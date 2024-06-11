import Foundation
import SwiftAPIClient
import SwiftMusicServicesApi

extension Amazon.Music {
    
    public struct DeviceAPI {
        
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
            self.client = client
                .url(Self.baseURL)
                .tokenRefresher(cacheService: cache) { refreshToken, _, _ in
                    let token = try await Amazon.Auth(
                        client: client,
                        clientID: clientID,
                        clientSecret: clientSecret,
                        redirectURI: redirectURI
                    )
                    .refreshToken(cache: cache)
                    return (token.access_token, token.refresh_token, Date(timeIntervalSinceNow: token.expires_in))
                } auth: { token in
                    .bearer(token: token)
                }
            self.cache = cache
        }
        
        public init(
            client: APIClient,
            clientID: String,
            clientSecret: String,
            redirectURI: String,
            accessToken: String? = nil,
            refreshToken: String? = nil,
            expiryIn: Double? = nil
        ) {
            let cache = MockSecureCacheService([
                .accessToken: accessToken,
                .refreshToken: refreshToken,
            ].compactMapValues { $0 })
            
            self.init(
                client: client,
                clientID: clientID,
                clientSecret: clientSecret,
                redirectURI: redirectURI,
                cache: cache
            )
            if let expiryIn {
                Task {
                    try await cache.save(Date(timeIntervalSinceNow: expiryIn), for: .expiryDate)
                }
            }
        }
    
        public func update(accessToken: String, refreshToken: String, expiresIn: Double?) async {
            try? await cache.save(accessToken, for: .accessToken)
            try? await cache.save(refreshToken, for: .refreshToken)
            try? await cache.save(expiresIn.map { Date(timeIntervalSinceNow: $0) }, for: .expiryDate)
        }
    }
}
