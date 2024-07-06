import Foundation
import SwiftAPIClient
@_exported import SwiftMusicServicesApi

extension Tidal {
    
    public final class Auth {
        
        public static let baseURL = URL(string: "https://auth.tidal.com/v1/oauth2")!
        public static let redirectURI = "https://account.tidal.com/login/tidal/return"
        public let client: APIClient
        public let clientID: String
        public let clientSecret: String
        public let redirectURI: String
        private var codeVerifier: String?
        package var onLogin: ((Result<Tidal.Objects.TokenResponse, Error>) -> Void)?
        
        public init(
            client: APIClient = APIClient(),
            clientID: String,
            clientSecret: String,
            redirectURI: String = Auth.redirectURI
        ) {
            self.client = client.url(Auth.baseURL)
                .bodyEncoder(
                    .formURL(
                        keyEncodingStrategy: .convertToSnakeCase,
                        arrayEncodingStrategy: .separator(" ")
                    )
                )
                .errorDecoder(.decodable(Tidal.Objects.Error.self))
                .auth(.basic(username: clientID, password: clientSecret))
            self.clientID = clientID
            self.clientSecret = clientSecret
            self.redirectURI = redirectURI
        }
        
        /// Requests an authorization code from Tidal.
        ///
        /// - Parameters:
        ///   - scope: The scope of the request.
        ///   - state: An opaque value used by the client to maintain state between this request and the response.
        ///   - codeChallengeMethod: The method used to encode the code_verifier for the codeChallenge parameter.  Used to secure authorization code grants via Proof Key for Code Exchange (PKCE).
        public func authURL(
            scope: Tidal.Objects.Scope = [.rUsr, .wUsr],
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
            return try? client.url("")
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
        /// - Throws: ``YouTube.OAuth.Error``
        public func codeFrom(redirected url: String) throws -> String? {
            if url.contains("?code=") {
                return url.components(separatedBy: "?code=")[1]
            } else if url.contains("?error=") {
                throw Tidal.Objects.Error(error: url.components(separatedBy: "?error=")[1])
            } else {
                return nil
            }
        }
        
        public func token(
            code: String,
            clientUniqueKey: String? = nil,
            scope: Tidal.Objects.Scope = [.rUsr, .wUsr],
            cache: SecureCacheService
        ) async throws -> Tidal.Objects.TokenResponse {
            do {
                let tokens = try await client("token")
                    .body([
                        "grant_type": "authorization_code",
                        "client_id": clientID,
                        "client_secret": codeVerifier == nil ? clientSecret : nil,
                        "redirect_uri": redirectURI,
                        "code_verifier": codeVerifier,
                        "client_unique_key": clientUniqueKey,
                        "scope": scope,
                        "code": code
                    ])
                    .post
                    .call(.http, as: .decodable(Tidal.Objects.TokenResponse.self))
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
        ) async throws -> Tidal.Objects.TokenResponse {
            let tokens = try await client("token")
                .body([
                    "grant_type": "refresh_token",
                    "client_id": clientID,
                    "refresh_token": cache.load(for: .refreshToken)
                ])
                .post
                .call(.http, as: .decodable(Tidal.Objects.TokenResponse.self))
            try? await cache.save(tokens.access_token, for: .accessToken)
            try? await cache.save(tokens.refresh_token, for: .refreshToken)
            try? await cache.save(Date(timeIntervalSinceNow: tokens.expires_in), for: .expiryDate)
            return tokens
        }
        
        
        // MARK: - Device
        
        public func token(
            deviceAuthResponse: Tidal.Objects.DeviceAuthorizationResponse,
            cache: SecureCacheService
        ) async throws -> Tidal.Objects.DeviceTokenResponse {
            let response = try await client("token")
                .body([
                    "grant_type": "device_code",
                    "device_code": deviceAuthResponse.device_code,
                    "user_code": deviceAuthResponse.user_code
                ])
                .post
                .call(.http, as: .decodable(Tidal.Objects.DeviceTokenResponse.self))
            if case let .success(tokens) = response {
                try? await cache.save(tokens.access_token, for: .accessToken)
                try? await cache.save(tokens.refresh_token, for: .refreshToken)
                try? await cache.save(Date(timeIntervalSinceNow: tokens.expires_in), for: .expiryDate)
            }
            return response
        }
        
        public func codepair(
            responseType: Tidal.Objects.ResponseType = .deviceCode,
            scope: [Tidal.Objects.Scope]
        ) async throws -> Tidal.Objects.DeviceAuthorizationResponse {
            try await client("create", "codepair")
                .body(Tidal.Objects.PostCodePair(
                    response_type: responseType,
                    client_id: clientID,
                    scope: scope
                ))
                .post()
        }
        
        public func waitForToken(
            authResponse: Tidal.Objects.DeviceAuthorizationResponse,
            cache: SecureCacheService
        ) async throws -> Tidal.Objects.TokenResponse {
            var date = Date()
            var codeExpireDate = Date(timeIntervalSinceNow: authResponse.expires_in)
            while date < codeExpireDate {
                try Task.checkCancellation()
                switch try await token(deviceAuthResponse: authResponse, cache: cache) {
                case .pending:
                    try await Task.sleep(nanoseconds: UInt64(authResponse.interval * 1_000_000_000))
                case let .success(response):
                    return response
                }
            }
            throw Tidal.Objects.Error.expiredToken
        }
    }
}

extension Tidal.Objects.Error {

    public static let authorizationPending = Self(error: "authorization_pending")
    public static let expiredToken = Self(error: "expired_token")
}

extension Tidal.Objects {
    
    public struct PostCodePair: Codable {
        public var response_type: Tidal.Objects.ResponseType
        public var client_id: String
        public var scope: [Tidal.Objects.Scope]
        public init(response_type: Tidal.Objects.ResponseType, client_id: String, scope: [Tidal.Objects.Scope]) {
            self.response_type = response_type
            self.client_id = client_id
            self.scope = scope
        }
    }
    
    public struct Scope: Hashable, ExpressibleByStringLiteral, LosslessStringConvertible, Codable, ExpressibleByArrayLiteral {

        public static let rUsr = Self("r_usr")
        public static let wUsr = Self("w_usr")
        public static let wSub = Self("w_sub")
        
        public var value: String
        public var description: String { value }
        public init(_ value: String) { self.value = value }
        public init(from decoder: any Decoder) throws { try self.init(String(from: decoder)) }
        public init(stringLiteral value: String) { self.init(value) }
        public func encode(to encoder: any Encoder) throws { try value.encode(to: encoder) }
        public init(arrayLiteral elements: Self...) {
            self.init(elements.map(\.value).joined(separator: "+"))
        }
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
        /// Required to submit a Device Token Request to Login with Tidal, to obtain the user’s access and refresh token.
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
                self = try .success(Tidal.Objects.TokenResponse(from: decoder))
            } catch {
                if let failure = try? Tidal.Objects.Error(from: decoder) {
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
                try Tidal.Objects.Error.authorizationPending.encode(to: encoder)
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
        /// Will always be bearer.
        public var token_type: String
        /// The number of seconds the access token is valid.
        public var expires_in: Double
        /// The user associated with the token.
        public var user: Tidal.Objects.User?
        public var user_id: Int?

        public init(access_token: String, refresh_token: String, token_type: String, expires_in: Double, user: Tidal.Objects.User? = nil, user_id: Int? = nil) {
            self.access_token = access_token
            self.refresh_token = refresh_token
            self.token_type = token_type
            self.expires_in = expires_in
            self.user = user
            self.user_id = user_id
        }
    }
}

private struct InvalidRedirectUrl: Error {}
