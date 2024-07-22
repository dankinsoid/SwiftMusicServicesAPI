import Foundation
import SwiftAPIClient
import SwiftMusicServicesApi

public enum Tidal {


    public enum API {}
    public enum Objects {}
}

extension Tidal.API {

    public static let desktopClientID = "mhPVJJEBNRzVjr2p"

    public struct V1 {

        public var client: APIClient

        public init(
            client: APIClient = APIClient(),
            clientID: String,
            clientSecret: String,
            redirectURI: String,
            cache: SecureCacheService,
            tokens: Tidal.Objects.TokenResponse? = nil
        ) {
            self.client = client
                .url("https://api.tidal.com/v1")
                .tokenRefresher { refreshToken, _, _ in
                    let token = try await Tidal.Auth(client: client, clientID: clientID, clientSecret: clientSecret, redirectURI: redirectURI)
                        .refreshToken(cache: cache)
                    return (token.access_token, token.refresh_token, token.expiresAt)
                } auth: {
                    .bearer(token: $0)
                }
                .auth(enabled: true)
        }
    }
}
