import Foundation
import SwiftAPIClient
@_exported import SwiftMusicServicesApi

extension Amazon {

    public final class Auth {

        public static let baseURL = URL(string: "https://api.amazon.com/auth/o2")!
        public let client: APIClient
        public let clientID: String
        public let clientSecret: String
        public let redirectURI: String
        private var codeVerifier: String?
        package var onLogin: ((Result<Amazon.Objects.TokenResponse, Error>) -> Void)?

        public init(
            client: APIClient = APIClient(),
            clientID: String,
            clientSecret: String,
            redirectURI: String
        ) {
            self.client = client.url(Self.baseURL)
                .bodyEncoder(
                    .formURL(
                        keyEncodingStrategy: .convertToSnakeCase,
                        arrayEncodingStrategy: .separator(" ")
                    )
                )
                .errorDecoder(.decodable(Amazon.Objects.Error.self))
                .auth(.basic(username: clientID, password: clientSecret))
            self.clientID = clientID
            self.clientSecret = clientSecret
            self.redirectURI = redirectURI
        }

        /// Requests an authorization code from Amazon.
        ///
        /// - Parameters:
        ///   - scope: The scope of the request. Must be `profile`, `profile:user_id`, `postal_code`, or some combination.
        ///   - state: An opaque value used by the client to maintain state between this request and the response.
        ///   - codeChallengeMethod: The method used to encode the code_verifier for the codeChallenge parameter.  Used to secure authorization code grants via Proof Key for Code Exchange (PKCE).
        public func authURL(
            scope: [Amazon.Objects.Scope],
            state: String? = nil,
            codeChallengeMethod: CodeChallengeMethod? = nil
        ) -> URL? {
            let code_challenge: String?
            if let codeChallengeMethod, let (verifier, challenge) = generateCodeChallenge(method: codeChallengeMethod) {
                codeVerifier = verifier
                code_challenge = challenge
            } else {
                codeVerifier = nil
                code_challenge = nil
            }
            return try? client.url("https://api.amazon.com/ap/oa")
                .query([
                    "response_type": "code",
                    "client_id": clientID,
                    "scope": scope,
                    "redirect_uri": redirectURI,
                    "state": state,
                    "code_challenge": code_challenge,
                    "code_challenge_method": codeChallengeMethod
                ])
                .auth(enabled: true)
                .request()
                .url
        }

        /// - Returns: An auth code.
        public func codeFrom(redirected url: String) throws -> String? {
            guard let components = URLComponents(string: url) else { return nil }
            let items = components.queryItems ?? []
            if let value = items.first(where: { $0.name == "code" })?.value {
                return value
            } else if let error = items.first(where: { $0.name == "error" })?.value {
                throw Amazon.Objects.Error(error: error)
            } else {
                return nil
            }
        }

        public func token(
            code: String,
            cache: SecureCacheService
        ) async throws -> Amazon.Objects.TokenResponse {
            do {
                let tokens = try await client("token")
                    .body([
                        "grant_type": "authorization_code",
                        "client_id": clientID,
                        "client_secret": clientSecret,
                        "redirect_uri": redirectURI,
                        "code_verifier": codeVerifier,
                        "code": code
                    ])
                    .post
                    .call(.http, as: .decodable(Amazon.Objects.TokenResponse.self))
                try? await cache.save(tokens.access_token, for: .accessToken)
                try? await cache.save(tokens.refresh_token, for: .refreshToken)
                try? await cache.save(Date(timeIntervalSinceNow: tokens.expires_in), for: .expiryDate)
                onLogin?(.success(tokens))
                return tokens
            } catch {
                onLogin?(.failure(error))
                throw error
            }
        }

        public func refreshToken(
            cache: SecureCacheService
        ) async throws -> Amazon.Objects.TokenResponse {
            let tokens = try await client("token")
                .body([
                    "grant_type": "refresh_token",
                    "client_id": clientID,
                    "refresh_token": cache.load(for: .refreshToken)
                ])
                .post
                .call(.http, as: .decodable(Amazon.Objects.TokenResponse.self))
            try? await cache.save(tokens.access_token, for: .accessToken)
            try? await cache.save(tokens.refresh_token, for: .refreshToken)
            try? await cache.save(Date(timeIntervalSinceNow: tokens.expires_in), for: .expiryDate)
            return tokens
        }
        
    
        // MARK: - Device

        public func token(
            deviceAuthResponse: Amazon.Objects.DeviceAuthorizationResponse,
            cache: SecureCacheService
        ) async throws -> Amazon.Objects.DeviceTokenResponse {
            let response = try await client("token")
                .body([
                    "grant_type": "device_code",
                    "device_code": deviceAuthResponse.device_code,
                    "user_code": deviceAuthResponse.user_code
                ])
                .post
                .call(.http, as: .decodable(Amazon.Objects.DeviceTokenResponse.self))
            if case let .success(tokens) = response {
                try? await cache.save(tokens.access_token, for: .accessToken)
                try? await cache.save(tokens.refresh_token, for: .refreshToken)
                try? await cache.save(Date(timeIntervalSinceNow: tokens.expires_in), for: .expiryDate)
            }
            return response
        }

        public func codepair(
            responseType: Amazon.Objects.ResponseType = .deviceCode,
            scope: [Amazon.Objects.Scope]
        ) async throws -> Amazon.Objects.DeviceAuthorizationResponse {
            try await client("create", "codepair")
                .body(Amazon.Objects.PostCodePair(
                    response_type: responseType,
                    client_id: clientID,
                    scope: scope
                ))
                .post()
        }

        public func waitForToken(
            authResponse: Amazon.Objects.DeviceAuthorizationResponse,
            cache: SecureCacheService
        ) async throws -> Amazon.Objects.TokenResponse {
            let codeExpireDate = Date(timeIntervalSinceNow: authResponse.expires_in)
            while Date() < codeExpireDate {
                try Task.checkCancellation()
                switch try await token(deviceAuthResponse: authResponse, cache: cache) {
                case .pending:
                    try await Task.sleep(nanoseconds: UInt64(authResponse.interval * 1_000_000_000))
                case let .success(response):
                    return response
                }
            }
            throw Amazon.Objects.Error.expiredToken
        }
    }
}

extension Amazon.Objects.Error {

    public static let authorizationPending = Self(error: "authorization_pending")
    public static let expiredToken = Self(error: "expired_token")
}

extension Amazon.Objects {
    
    public struct PostCodePair: Codable {
        public var response_type: Amazon.Objects.ResponseType
        public var client_id: String
        public var scope: [Amazon.Objects.Scope]
        public init(response_type: Amazon.Objects.ResponseType, client_id: String, scope: [Amazon.Objects.Scope]) {
            self.response_type = response_type
            self.client_id = client_id
            self.scope = scope
        }
    }
    
    public struct Scope: Hashable, ExpressibleByStringLiteral, LosslessStringConvertible, Codable {

        /// Access the user's profile information.
        public static let profile = Self("profile")
        /// Access the user's postal code.
        public static let postalCode = Self("postal_code")
        /// Access Amazon Music.
        public static let musicAccess = Self("amazon_music:access")

        /// Search the Amazon music catalog.
        public static let musicCatalog = Self("music::catalog")
        /// Read and update the users and artists a customer follows.
        public static let musicFavorites = Self("music::favorites")
        /// Read the users and artists a customer follows.
        public static let musicFavoritesRead = Self("music::favorites:read")
        /// Read a customer's listening history.
        public static let musicHistory = Self("music::history")
        /// Read and update a customer's music library and playlists.
        public static let musicLibrary = Self("music::library")
        /// Read a customer's music library and playlists.
        public static let musicLibraryRead = Self("music::library:read")
        /// Enable Amazon Music media playback and playback device discovery.
        public static let musicPlayback = Self("music::playback")
        /// Read and update a customer's music profile settings.
        public static let musicProfile = Self("music::profile")
        /// Read a customer's music profile and settings.
        public static let musicProfileRead = Self("music::profile:read")
        /// Read Amazon Music recommendations on a customer's behalf.
        public static let musicRecommendation = Self("music::recommendation")

        public var value: String
        public var description: String { value }
        public init(_ value: String) { self.value = value }
        public init(from decoder: any Decoder) throws { try self.init(String(from: decoder)) }
        public init(stringLiteral value: String) { self.init(value) }
        public func encode(to encoder: any Encoder) throws { try value.encode(to: encoder) }
    }
    
    public struct ResponseType: Hashable, ExpressibleByStringLiteral, LosslessStringConvertible, Codable {
        
        public static let deviceCode = Self("device_code")

        public var value: String
        public var description: String { value }
        public init(_ value: String) { self.value = value }
        public init(from decoder: any Decoder) throws { try self.init(String(from: decoder)) }
        public init(stringLiteral value: String) { self.init(value) }
        public func encode(to encoder: any Encoder) throws { try value.encode(to: encoder) }
    }
    
    public struct DeviceAuthorizationResponse: Codable, Equatable {

        /// The code to display to the user.
        public var user_code: String
        /// Required to submit a Device Token Request to Login with Amazon, to obtain the user’s access and refresh token.
        public var device_code: String
        /// The URL to display to the user.
        public var verification_uri: String
        /// The length of time in seconds the device_code is valid.
        public var expires_in: Double
        /// The length of time in seconds you should wait between each Device Token Request.
        public var interval: Double
        
        public init(user_code: String, device_code: String, verification_uri: String, expires_in: Double, interval: Double) {
            self.user_code = user_code
            self.device_code = device_code
            self.verification_uri = verification_uri
            self.expires_in = expires_in
            self.interval = interval
        }
    }
    
    public enum DeviceTokenResponse: Codable, Equatable {
        
        case pending
        case success(TokenResponse)
        
        public init(from decoder: any Decoder) throws {
            do {
                self = try .success(Amazon.Objects.TokenResponse(from: decoder))
            } catch {
                if let failure = try? Amazon.Objects.Error(from: decoder) {
                    if failure == .authorizationPending {
                        self = .pending
                    } else {
                        throw failure
                    }
                } else {
                    throw error
                }
            }
        }

        public func encode(to encoder: any Encoder) throws {
            switch self {
            case .pending:
                try Amazon.Objects.Error.authorizationPending.encode(to: encoder)
            case let .success(token):
                try token.encode(to: encoder)
            }
        }
    }

    public struct TokenResponse: Codable, Equatable {

        /// The access token for the user. Maximum size of 2048 bytes.
        public var access_token: String
        /// The refresh token that can be used to request a new access token. Maximum size of 2048 bytes.
        public var refresh_token: String
        /// The number of seconds the access token is valid.
        public var expires_in: Double
        
        public init(access_token: String, refresh_token: String, expires_in: Double) {
            self.access_token = access_token
            self.refresh_token = refresh_token
            self.expires_in = expires_in
        }
    }
}

private struct InvalidRedirectUrl: Error {}
