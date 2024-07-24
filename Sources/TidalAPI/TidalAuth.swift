import Foundation
import SwiftAPIClient
@_exported import SwiftMusicServicesApi

extension Tidal {

    public final class Auth {

        public static let baseURL = URL(string: "https://auth.tidal.com/v1/oauth2")!
        public static let redirectURIWeb = "https://account.tidal.com/login/tidal/return"
        public static let redirectURIDesktop = "tidal://login/auth"

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
            redirectURI: String
        ) {
            self.client = client.url(Auth.baseURL)
                .bodyEncoder(
                    .formURL(
                        keyEncodingStrategy: .convertToSnakeCase,
                        arrayEncodingStrategy: .separator(" ")
                    )
                )
                .bodyDecoder(.json(dateDecodingStrategy: .tidal))
                .errorDecoder(.decodable(Tidal.Objects.Error.self))
                .auth(.basic(username: clientID, password: clientSecret))
                .httpResponseValidator(.statusCode)
            self.clientID = clientID
            self.clientSecret = clientSecret
            self.redirectURI = redirectURI
        }

        /// Requests an authorization code from Tidal.
        ///
        /// - Parameters:
        ///   - scope: The scope of the request.
        ///   - state: An opaque value used by the client to maintain state between this request and the response.
        ///   - restrictSignup: If true, the user will be prompted to sign in with an existing account.
        ///   - language: The language of the login page.
        ///   - codeVerifier: Used to secure authorization code grants via Proof Key for Code Exchange (PKCE).
        ///   - codeChallenge: Used to secure authorization code grants via Proof Key for Code Exchange (PKCE).
        ///   - codeChallengeMethod: The method used to encode the code_verifier for the codeChallenge parameter.  Used to secure authorization code grants via Proof Key for Code Exchange (PKCE).
        public func authURL(
            scope: Tidal.Objects.Scope = [.rUsr, .wUsr],
            state: String? = nil,
            restrictSignup: Bool = true,
            language: String = "en",
            codeVerifier: String?,
            codeChallenge: String?,
            codeChallengeMethod: CodeChallengeMethod? = .S256
        ) -> URL? {
            self.codeVerifier = codeVerifier
            return try? URL(string: "https://login.tidal.com/authorize")?
                .query(
                    [
                        "response_type": "code",
                        "client_id": clientID,
                        "scope": scope,
                        "redirect_uri": redirectURI,
                        "state": state,
                        "language": language,
                        "restrictSignup": restrictSignup,
                        "code_challenge": codeChallenge,
                        "code_challenge_method": codeChallengeMethod
                    ],
                    queryEncoder: .urlQuery(arrayEncodingStrategy: .separator(" "))
                )
        }
    
        /// Requests an authorization code from Tidal.
        ///
        /// - Parameters:
        ///   - scope: The scope of the request.
        ///   - state: An opaque value used by the client to maintain state between this request and the response.
        ///   - restrictSignup: If true, the user will be prompted to sign in with an existing account.
        ///   - language: The language of the login page.
        ///   - codeChallengeMethod: The method used to encode the code_verifier for the codeChallenge parameter.  Used to secure authorization code grants via Proof Key for Code Exchange (PKCE).
        public func authURL(
            scope: Tidal.Objects.Scope = [.rUsr, .wUsr],
            state: String? = nil,
            restrictSignup: Bool = true,
            language: String = "en",
            codeChallengeMethod: CodeChallengeMethod? = .S256
        ) -> URL? {
            let code_challenge: String?
            if let codeChallengeMethod, let (verifier, challenge) = generateCodeChallenge(method: codeChallengeMethod) {
                codeVerifier = verifier
                code_challenge = challenge
            } else {
                codeVerifier = nil
                code_challenge = nil
            }
            return authURL(
                scope: scope,
                state: state,
                restrictSignup: restrictSignup,
                language: language,
                codeVerifier: codeVerifier,
                codeChallenge: code_challenge,
                codeChallengeMethod: codeChallengeMethod
            )
        }

        /// - Returns: An auth code.
        /// - Throws: ``Tidal.Auth.Error``
        public func codeFrom(redirected url: String) throws -> String? {
            guard let components = URLComponents(string: url) else { return nil }
            let items = components.queryItems ?? []
            if let value = items.first(where: { $0.name == "code" })?.value {
                return value
            } else if let error = items.first(where: { $0.name == "error" })?.value {
                throw Tidal.Objects.Error(error: error)
            } else {
                return nil
            }
        }

        public func token(
            code: String,
            clientUniqueKey: String? = nil,
            scope: Tidal.Objects.Scope = [.rUsr, .wUsr],
            codeVerifier: String? = nil,
            cache: SecureCacheService
        ) async throws -> Tidal.Objects.TokenResponse {
            do {
                let codeVerifier = codeVerifier ?? self.codeVerifier
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
                try? await cache.save(tokens.user_id ?? tokens.user?.id, for: "userID")
                try? await cache.save(tokens.user?.countryCode, for: .countryCode)
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
            try? await cache.save(tokens.user_id ?? tokens.user?.id, for: "userID")
            try? await cache.save(tokens.user?.countryCode, for: .countryCode)
            try? await cache.save(Date(timeIntervalSinceNow: tokens.expires_in), for: .expiryDate)
            return tokens
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

        public init(access_token: String, refresh_token: String, token_type: String = "Bearer", expires_in: Double, user: Tidal.Objects.User? = nil, user_id: Int? = nil) {
            self.access_token = access_token
            self.refresh_token = refresh_token
            self.token_type = token_type
            self.expires_in = expires_in
            self.user = user
            self.user_id = user_id
        }

        public var userID: Int? {
            user_id ?? user?.id
        }

        public var expiresAt: Date {
            Date(timeIntervalSinceNow: expires_in)
        }
    }
}

private struct InvalidRedirectUrl: Error {}
