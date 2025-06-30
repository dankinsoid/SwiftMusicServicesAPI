import Foundation
import SwiftAPIClient
@_exported import SwiftMusicServicesApi

public extension Tidal.API.V2 {

    final class Auth {

        public static let authBaseURL = URL(string: "https://login.tidal.com")!
        public static let tokenBaseURL = URL(string: "https://auth.tidal.com/v1/oauth2")!

        public let client: APIClient
        public let clientID: String
        public let clientSecret: String
        public let redirectURI: String
        private var codeVerifier: String?

        public init(
            client: APIClient = APIClient(),
            clientID: String,
            clientSecret: String,
            redirectURI: String
        ) {
            self.client = client.url(Self.tokenBaseURL)
                .bodyEncoder(
                    .formURL(
                        keyEncodingStrategy: .convertToSnakeCase,
                        arrayEncodingStrategy: .separator(" ")
                    )
                )
                .bodyDecoder(.json(dateDecodingStrategy: .tidal))
                .errorDecoder(.decodable(TDO.ErrorDocument.self))
                .httpResponseValidator(.statusCode)
            self.clientID = clientID
            self.clientSecret = clientSecret
            self.redirectURI = redirectURI
        }

        /// Client credentials flow - Access tokens without user context
        public func clientCredentials(
            cache: SecureCacheService
        ) async throws -> TokenResponse {
            let response = try await client("token")
                .auth(.basic(username: clientID, password: clientSecret))
                .body(["grant_type": "client_credentials"])
                .post
                .call(.http, as: .decodable(TokenResponse.self))

            try? await cache.save(response.accessToken, for: .accessToken)
            if let expiresAt = response.expiresAt {
                try? await cache.save(expiresAt, for: .expiryDate)
            }

            return response
        }

        /// Generate authorization URL for user login flow
        public func authorizationURL(
            scopes: [String] = [],
            state: String? = nil,
            codeChallengeMethod: CodeChallengeMethod = .S256
        ) -> URL? {
            let (verifier, challenge) = generateCodeChallenge(method: codeChallengeMethod) ?? ("", "")
            codeVerifier = verifier

            var components = URLComponents(url: Self.authBaseURL.appendingPathComponent("authorize"), resolvingAgainstBaseURL: false)
            components?.queryItems = [
                URLQueryItem(name: "response_type", value: "code"),
                URLQueryItem(name: "client_id", value: clientID),
                URLQueryItem(name: "redirect_uri", value: redirectURI),
                URLQueryItem(name: "code_challenge_method", value: codeChallengeMethod.rawValue),
                URLQueryItem(name: "code_challenge", value: challenge),
            ]

            if !scopes.isEmpty {
                components?.queryItems?.append(URLQueryItem(name: "scope", value: scopes.joined(separator: " ")))
            }

            if let state {
                components?.queryItems?.append(URLQueryItem(name: "state", value: state))
            }

            return components?.url
        }

        /// Extract authorization code from redirect URL
        public func extractAuthorizationCode(from redirectURL: String) throws -> String {
            guard let components = URLComponents(string: redirectURL),
                  let queryItems = components.queryItems
            else {
                throw AuthError.invalidRedirectURL
            }

            if let error = queryItems.first(where: { $0.name == "error" })?.value {
                let description = queryItems.first(where: { $0.name == "error_description" })?.value
                throw AuthError.authorizationFailed(error: error, description: description)
            }

            guard let code = queryItems.first(where: { $0.name == "code" })?.value else {
                throw AuthError.missingAuthorizationCode
            }

            return code
        }

        /// Exchange authorization code for tokens
        public func exchangeCodeForTokens(
            code: String,
            codeVerifier: String? = nil,
            cache: SecureCacheService
        ) async throws -> TokenResponse {
            let verifier = codeVerifier ?? self.codeVerifier

            let response = try await client("token")
                .body([
                    "grant_type": "authorization_code",
                    "client_id": clientID,
                    "code": code,
                    "redirect_uri": redirectURI,
                    "code_verifier": verifier,
                ])
                .post
                .call(.http, as: .decodable(TokenResponse.self))

            try? await cache.save(response.accessToken, for: .accessToken)
            if let refreshToken = response.refreshToken {
                try? await cache.save(refreshToken, for: .refreshToken)
            }
            if let expiresAt = response.expiresAt {
                try? await cache.save(expiresAt, for: .expiryDate)
            }

            return response
        }

        /// Refresh access token using refresh token
        public func refreshToken(
            refreshToken: String? = nil,
            cache: SecureCacheService
        ) async throws -> TokenResponse {
            let token: String
            if let refreshToken {
                token = refreshToken
            } else {
                token = try await cache.load(for: .refreshToken).unwrap(throwing: "No refresh token found in cache")
            }

            let response = try await client("token")
                .body([
                    "grant_type": "refresh_token",
                    "refresh_token": token,
                ])
                .post
                .call(.http, as: .decodable(TokenResponse.self))

            try? await cache.save(response.accessToken, for: .accessToken)
            if let newRefreshToken = response.refreshToken {
                try? await cache.save(newRefreshToken, for: .refreshToken)
            }
            if let expiresAt = response.expiresAt {
                try? await cache.save(expiresAt, for: .expiryDate)
            }

            return response
        }
    }
}

// MARK: - Models

public extension Tidal.API.V2.Auth {

    struct TokenResponse: Codable, Equatable, Sendable {
        public let accessToken: String
        public let tokenType: String
        public let expiresIn: Double?
        public let refreshToken: String?
        public let scope: String?

        private enum CodingKeys: String, CodingKey {
            case accessToken = "access_token"
            case tokenType = "token_type"
            case expiresIn = "expires_in"
            case refreshToken = "refresh_token"
            case scope
        }

        public var expiresAt: Date? {
            expiresIn.map { Date(timeIntervalSinceNow: $0) }
        }
    }

    enum AuthError: Error, LocalizedError {
        case invalidRedirectURL
        case missingAuthorizationCode
        case authorizationFailed(error: String, description: String?)

        public var errorDescription: String? {
            switch self {
            case .invalidRedirectURL:
                return "Invalid redirect URL"
            case .missingAuthorizationCode:
                return "Missing authorization code in redirect URL"
            case let .authorizationFailed(error, description):
                return "Authorization failed: \(error)\(description.map { " - \($0)" } ?? "")"
            }
        }
    }
}
