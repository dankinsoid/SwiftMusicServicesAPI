import Foundation
import SwiftMusicServicesApi
import SwiftAPIClient

public enum YouTube {
    public enum Objects {}
}

public typealias YTM = YouTube
public typealias YTMO = YouTube.Objects

extension YouTube {

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
                .errorDecoder(.decodable(YTMO.ErrorResponse.self))
                .httpResponseValidator(.statusCode)
                .modifyRequest { components, configs in
                    if let key = HTTPField.Name("x-goog-api-key") {
                        components.headers[key] = apiKey
                    }
                }
        }
    }
}
