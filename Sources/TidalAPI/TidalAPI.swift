import Foundation
import SwiftAPIClient
import SwiftMusicServicesApi

public enum Tidal {

    public enum API {}
    public enum Objects {}
}

public typealias TDO = Tidal.Objects

public extension Tidal.API {

    static let desktopClientID = "mhPVJJEBNRzVjr2p"

    struct V1 {

        public var client: APIClient
        public let cache: SecureCacheService

        public init(
            client: APIClient = APIClient(),
            clientID: String,
            clientSecret: String,
            redirectURI: String,
            defaultCountryCode: String = "US",
            cache: SecureCacheService
        ) {
            self.client = client
                .url("https://api.tidal.com/v1")
                .tokenRefresher(cacheService: cache) { _, _, _ in
                    let token = try await Tidal.Auth(client: client, clientID: clientID, clientSecret: clientSecret, redirectURI: redirectURI)
                        .refreshToken(cache: cache)
                    return (token.access_token, token.refresh_token, token.expiresAt)
                } auth: {
                    .bearer(token: $0)
                }
                .httpClientMiddleware(CountryCodeRequestMiddleware(cache: cache, defaultCountryCode: defaultCountryCode))
                .auth(enabled: true)
                .bodyDecoder(.json(dateDecodingStrategy: .tidal, dataDecodingStrategy: .base64))
                .errorDecoder(.decodable(Tidal.Objects.Error.self))
                .bodyEncoder(.formURL(arrayEncodingStrategy: .commaSeparator))
								.finalizeRequest { request, _ in
									if request.headers[.authorization] == nil, let name = HTTPField.Name("x-tidal-token") {
										request.headers[name] = clientID
									}
								}
                .httpResponseValidator(.statusCode)
            self.cache = cache
        }

        public init(
            client: APIClient = APIClient(),
            clientID: String,
            clientSecret: String,
            redirectURI: String,
            defaultCountryCode: String = "en_US",
            tokens: Tidal.Objects.TokenResponse?
        ) {
            self.init(
                client: client,
                clientID: clientID,
                clientSecret: clientSecret,
                redirectURI: redirectURI,
                cache: MockSecureCacheService([
                    .accessToken: tokens?.access_token,
                    .refreshToken: tokens?.refresh_token,
                    .expiryDate: (tokens?.expiresAt).map(DateFormatter.secureCacheService.string),
                    .countryCode: tokens?.user?.countryCode ?? defaultCountryCode,
                ].compactMapValues { $0 })
            )
        }

        public func setTokens(_ tokens: Tidal.Objects.TokenResponse) async {
            try? await cache.save(tokens.access_token, for: .accessToken)
            if let refreshToken = tokens.refresh_token {
                try? await cache.save(refreshToken, for: .refreshToken)
            }
            if let expiryDate = tokens.expiresAt {
                try? await cache.save(expiryDate, for: .expiryDate)
            }
            if let countryCode = tokens.user?.countryCode {
                try? await cache.save(countryCode, for: .countryCode)
            }
        }
    }
}

public extension Tidal.API {

    static func url(type: String, _ path: String, width: Int, height: Int) -> URL? {
        URL(string: "https://resources.tidal.com")?
            .path(type)
            .path(path.components(separatedBy: "-"))
            .path("\(width)x\(height).jpg")
    }

    static func imageUrl(_ path: String, width: Int, height: Int) -> URL? {
        url(type: "images", path, width: width, height: height)
    }

    static func videoUrl(_ path: String, width: Int, height: Int) -> URL? {
        url(type: "videos", path, width: width, height: height)
    }
}

public extension SecureCacheServiceKey {

    static let countryCode = SecureCacheServiceKey("countryCode")
}

struct CountryCodeRequestMiddleware: HTTPClientMiddleware {

    let cache: SecureCacheService
    let defaultCountryCode: String

    func execute<T>(
        request: HTTPRequestComponents,
        configs: APIClient.Configs,
        next: @escaping @Sendable (HTTPRequestComponents, APIClient.Configs) async throws -> (T, HTTPResponse)
    ) async throws -> (T, HTTPResponse) {
        if request.urlComponents.queryItems?.contains(where: { $0.name == "countryCode" }) != true {
            let request = await request.query("countryCode", (try? cache.load(for: .countryCode)) ?? defaultCountryCode)
            return try await next(request, configs)
        }
        return try await next(request, configs)
    }
}

public extension JSONDecoder.DateDecodingStrategy {

    static let tidal: JSONDecoder.DateDecodingStrategy = .custom { decoder in
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
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter
}()
