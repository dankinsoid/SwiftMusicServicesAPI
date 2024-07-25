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
        public let clientID: String

        public init(
            client: APIClient = APIClient(),
            clientID: String = Self.desktopWebClientID,
            redirectURI: String,
            cache: SecureCacheService
        ) {
            self.client = client.url("https://api-v2.soundcloud.com")
                .tokenRefresher(cacheService: cache) { refreshToken, _, _ in
                    let result = try await SoundCloud.OAuth2(
                        client: client,
                        clientID: clientID,
                        redirectURI: redirectURI
                    )
                    .refreshToken(cache: cache)
                    return (result.accessToken, refreshToken, result.expiresIn.map { Date(timeIntervalSinceNow: $0) })
                } auth: { token in
                    .bearer(token: token)
                }
                .bodyEncoder(.json(dateEncodingStrategy: .iso8601))
                .bodyDecoder(.json(dateDecodingStrategy: .soundCloud))
                .queryEncoder(.urlQuery(arrayEncodingStrategy: .commaSeparator))
                .auth(enabled: true)
                .errorDecoder(.decodable(SCO.Error.self))
                .httpResponseValidator(.statusCode)
            self.clientID = clientID
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
                .expiryDate: expiryIn.flatMap(DateFormatter.secureCacheService.string)
            ].compactMapValues { $0 })

            self.init(
                client: client,
                clientID: clientID,
                redirectURI: redirectURI,
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

    public static let soundCloud: JSONDecoder.DateDecodingStrategy = .custom { decoder in
        let container = try decoder.singleValueContainer()
        let dateString: String
        do {
            dateString = try container.decode(String.self)
        } catch {
            let time = try container.decode(Double.self)
            return Date(timeIntervalSince1970: time)
        }
        if let date = isoDateFormatter.date(from: dateString) ?? dateFormatter.date(from: dateString) {
            return date
        }
        throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date format: \(dateString)")
        
    }
}

private let isoDateFormatter: ISO8601DateFormatter = {
    let dateFormatter = ISO8601DateFormatter()
    dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    return dateFormatter
}()

private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    return dateFormatter
}()
