import Foundation
import SwiftAPIClient
@_exported import SwiftMusicServicesApi

public typealias SCO = SoundCloud.Objects

public enum SoundCloud {
    
    public enum Objects {}

    public struct API {

        public static let desktopWebClientID = "iyGXviHE8xjNOJChYIx9xdZ2WKCqCfQm"
        public static let mobileWebClientID = "KKzJxmw11tYpCs6T24P4uUYhqmjalG6M"

        public let client: APIClient
        public let cache: SecureCacheService

        public init(
            client: APIClient = APIClient(),
            clientID: String = Self.desktopWebClientID,
            redirectURI: String,
            cache: SecureCacheService
        ) {
            self.client = client.url("https://api-v2.soundcloud.com")
//                .tokenRefresher(cacheService: cache) { refreshToken, _, _ in
//                    let result = try await SoundCloud.OAuth2(
//                        client: client,
//                        clientID: clientID,
//                        redirectURI: redirectURI
//                    )
//                        .refreshToken(
//                            refreshToken.unwrap(throwing: TokenNotFound())
//                        )
//                    return (result.accessToken, refreshToken, Date(timeIntervalSinceNow: result.expiresIn))
//                } auth: { token in
//                        .bearer(token: token)
//                }
                .bodyEncoder(.json(dateEncodingStrategy: .iso8601))
                .bodyDecoder(.json(dateDecodingStrategy: .iso8601))
                .queryEncoder(.urlQuery(arrayEncodingStrategy: .commaSeparator))
                .auth(enabled: true)
                .errorDecoder(.decodable(SCO.Error.self))
                .httpResponseValidator(.statusCode)
                .finalizeRequest { req, _ in
                    req = req.query("client_id", clientID)
                }
            self.cache = cache
        }
        
        public init(
            client: APIClient,
            clientID: String,
            redirectURI: String,
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
                redirectURI: redirectURI,
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
