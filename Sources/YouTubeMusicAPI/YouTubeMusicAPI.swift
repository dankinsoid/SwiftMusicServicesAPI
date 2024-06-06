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
        
        public enum BaseURL: String {
            
            /// Official primary domain name
            case baseURL = "https://music.youtube.com"
            
            public var url: URL {
                URL(string: rawValue)!
            }
        }

        public let client: APIClient

        public let clientID: String
        
        public init(
            baseURL: BaseURL,
            clientID: String,
            clientSecret: String,
            redirectURI: String,
            cache: SecureCacheService
        ) {
            self.client = APIClient(baseURL: baseURL.url)
                .tokenRefresher(cacheService: cache) { refreshToken, _, _ in
                    let result = try await YouTube.OAuth2(
                        clientID: clientID,
                        clientSecret: clientSecret,
                        redirectURI: redirectURI
                    )
                    .refreshToken(
                        refreshToken.unwrap(throwing: AnyError("No refresh token found"))
                    )
                    return (result.accessToken, refreshToken, Date(timeIntervalSinceNow: result.expiresIn))
                } auth: { token in
                    .bearer(token: token)
                }
            self.clientID = clientID
        }
    }
}
