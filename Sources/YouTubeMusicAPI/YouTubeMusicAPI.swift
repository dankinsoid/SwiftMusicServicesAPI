import Foundation
import SwiftMusicServicesApi
import SwiftAPIClient

public enum YouTube {
    public enum Music {
        public enum Objects {}
    }
}

public typealias YTM = YouTube.Music
public typealias YTMO = YouTube.Music.Objects

extension YouTube.Music {
    
    public struct API {

        public let client: APIClient

        public init(
            clientID: String,
            clientSecret: String,
            redirectURI: String,
            apiKey: String,
            cache: SecureCacheService
        ) {
            self.client = APIClient(string: "https://www.googleapis.com/youtube/v3")
                .tokenRefresher(cacheService: cache) { refreshToken, _, _ in
                    let result = try await YouTube.OAuth2(
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
                .modifyRequest { components, configs in
                    if let key = HTTPField.Name("x-goog-api-key") {
                        components.headers[key] = apiKey
                    }
                }
        }
    }
}
