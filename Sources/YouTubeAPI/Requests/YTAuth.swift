import Foundation
import SwiftMusicServicesApi
import SwiftAPIClient
import CryptoSwift

extension YouTube {

    public final class OAuth2 {

        package var onLogin: ((Result<YTO.OAuthToken, Swift.Error>) -> Void)?
        public let clientID: String
        public let clientSecret: String
        public let redirectURI: String
        private var codeVerifier: String?

        public let client: APIClient

        /// - Parameters:
        ///   - clientID: The client ID for your application. You can find this value in the API Console Credentials [page](https://console.developers.google.com/apis/credentials).
        ///   - clientSecret: The client secret obtained from the API Console Credentials [page](https://console.developers.google.com/apis/credentials).
        ///   - redirectURI: Determines where the API server redirects the user after the user completes the authorization flow.
        ///   The value must exactly match one of the authorized redirect URIs for the OAuth 2.0 client, which you configured in your client's API Console [Credentials page](https://console.developers.google.com/apis/credentials).
        ///   If this value doesn't match an authorized redirect URI for the provided client_id you will get a redirect_uri_mismatch error.
        ///   Note that the http or https scheme, case, and trailing slash ('/') must all match.
        public init(
            client: APIClient = APIClient(),
            clientID: String,
            clientSecret: String,
            redirectURI: String
        ) {
            self.client = client.url("https://oauth2.googleapis.com")
                .bodyEncoder(.formURL(keyEncodingStrategy: .convertToSnakeCase))
                .bodyDecoder(.json(keyDecodingStrategy: .convertFromSnakeCase))
                .errorDecoder(.decodable(YTO.ErrorResponse.self))
                .httpResponseValidator(.statusCode)
            self.clientID = clientID
            self.clientSecret = clientSecret
            self.redirectURI = redirectURI
        }

        /// Google OAuth 2.0 url
        ///
        /// - Parameters:
        ///   - responseType: Determines whether the Google OAuth 2.0 endpoint returns an authorization code. Set the parameter value to `code` for web server applications.
        ///   - scope: A space-delimited list of scopes that identify the resources that your application could access on the user's behalf.
        ///   These values inform the consent screen that Google displays to the user. Scopes enable your application to only request access to the resources that it needs while also enabling users to control the amount of access that they grant to your application.
        ///   Thus, there is an inverse relationship between the number of scopes requested and the likelihood of obtaining user consent.
        ///   The [OAuth 2.0 API Scopes](https://developers.google.com/identity/protocols/oauth2/scopes) document provides a full list of scopes that you might use to access Google APIs.
        ///   - accessType: Recommended. Indicates whether your application can refresh access tokens when the user is not present at the browser. Valid parameter values are online, which is the default value, and offline.
        ///   Set the value to offline if your application needs to refresh access tokens when the user is not present at the browser. This is the method of refreshing access tokens described later in this document.
        ///   This value instructs the Google authorization server to return a refresh token and an access token the first time that your application exchanges an authorization code for tokens.
        ///   - state: Specifies any string value that your application uses to maintain state between your authorization request and the authorization server's response.
        ///   The server returns the exact value that you send as a name=value pair in the URL query component (?) of the redirect_uri after the user consents to or denies your application's access request.
        ///   You can use this parameter for several purposes, such as directing the user to the correct resource in your application, sending nonces, and mitigating cross-site request forgery.
        ///   Since your redirect_uri can be guessed, using a state value can increase your assurance that an incoming connection is the result of an authentication request.
        ///   If you generate a random string or encode the hash of a cookie or another value that captures the client's state, you can validate the response to additionally ensure that the request and response originated in the same browser, providing protection against attacks such as [cross-site request forgery](https://datatracker.ietf.org/doc/html/rfc6749#section-10.12).
        ///   See the [OpenID Connect documentation](https://developers.google.com/identity/protocols/oauth2/openid-connect#createxsrftoken) for an example of how to create and confirm a state token.
        ///   - includeGrantedScopes: Enables applications to use incremental authorization to request access to additional scopes in context.
        ///   If you set this parameter's value to `true` and the authorization request is granted, then the new access token will also cover any scopes to which the user previously granted the application access.
        ///   See the [incremental authorization section](https://developers.google.com/youtube/v3/guides/auth/server-side-web-apps#incrementalAuth) for examples.
        ///   - enableGranularConsent: Defaults to `true`. If set to false, [more granular Google Account permissions](https://developers.google.com/identity/protocols/oauth2/resources/granular-permissions) will be disabled for OAuth client IDs created before 2019.
        ///   No effect for newer OAuth client IDs, since more granular permissions is always enabled for them.
        ///   - loginHint: If your application knows which user is trying to authenticate, it can use this parameter to provide a hint to the Google Authentication Server.
        ///   The server uses the hint to simplify the login flow either by prefilling the email field in the sign-in form or by selecting the appropriate multi-login session.
        ///   Set the parameter value to an email address or sub identifier, which is equivalent to the user's Google ID.
        ///   - prompt: A list of prompts to present the user. If you don't specify this parameter, the user will be prompted only the first time your project requests access.
        ///   See [Prompting re-consent](https://developers.google.com/identity/protocols/oauth2/openid-connect#re-consent) for more information.
        ///   - codeChallengeMethod: Specifies what method was used to encode a `code_verifier` that will be used during authorization code exchange.
        ///   The only supported values for this parameter are S256 or plain. When nil PCKE auth is not used.   .   
        public func authURL(
            responseType: String = "code",
            scope: [YouTube.Scope],
            accessType: YouTube.Objects.AccessType? = .offline,
            state: String?,
            includeGrantedScopes: Bool? = nil,
            enableGranularConsent: Bool? = nil,
            loginHint: String? = nil,
            prompt: [YouTube.Objects.Prompt]? = nil,
            codeChallengeMethod: YouTube.Objects.CodeChallengeMethod? = nil
        ) throws -> URL {
            try APIClient()
                .url("https://accounts.google.com/o/oauth2/v2/auth")
                .query([
                    "client_id": clientID,
                    "redirect_uri": redirectURI,
                    "response_type": responseType,
                    "scope": scope,
                    "access_type": accessType,
                    "state": state,
                    "include_granted_scopes": includeGrantedScopes,
                    "enable_granular_consent": enableGranularConsent,
                    "login_hint": loginHint,
                    "prompt": prompt,
                    "code_challenge": codeChallengeMethod.map(generateCodeChallenge)
                ])
                .queryEncoder(.urlQuery(arrayEncodingStrategy: .separator(" ")))
                .request()
                .url
                .unwrap(throwing: AnyError("Invalid URL string"))
        }
        
        /// - Returns: An auth code.
        /// - Throws: ``YouTube.OAuth.Error``
        public func codeFrom(redirected url: String) throws -> String {
            if url.contains("?code=") {
                return url.components(separatedBy: "?code=")[1]
            } else if url.contains("?error=") {
                throw Error(url.components(separatedBy: "?error=")[1])
            } else {
                throw Error.invalidRedirectUrl
            }
        }

        @discardableResult
        public func token(code: String, cache: SecureCacheService) async throws -> YTO.OAuthToken {
            do {
                let result: YTO.OAuthToken = try await client("token")
                    .body(
                        YTO.TokenRequest(
                            clientId: clientID,
                            clientSecret: clientSecret,
                            code: code,
                            codeVerifier: codeVerifier,
                            grantType: "authorization_code",
                            redirectUri: redirectURI
                        )
                    )
                    .post()
                codeVerifier = nil
                try? await cache.save(result.accessToken, for: .accessToken)
                try? await cache.save(result.refreshToken, for: .refreshToken)
                try? await cache.save(Date(timeIntervalSinceNow: result.expiresIn), for: .expiryDate)
                onLogin?(.success(result))
                return result
            } catch {
                onLogin?(.failure(error))
                throw error
            }
        }

        public func refreshToken(_ refreshToken: String) async throws -> YTO.OAuthRefreshedToken {
            try await client("token")
                .body(
                    YTO.TokenRequest(
                        clientId: clientID,
                        clientSecret: clientSecret,
                        grantType: "refresh_token",
                        refreshToken: refreshToken
                    )
                )
                .post()
        }
    }
}

public extension SecureCacheServiceKey {
    
    static let codeVerifier: SecureCacheServiceKey = "codeVerifier"
}

private struct ClientSecretMissing: Error {}

extension YouTube.OAuth2 {

    public enum Error: String, Swift.Error, Codable, CustomStringConvertible {

        /// The Google Account is unable to authorize one or more scopes requested due to the policies of their Google Workspace administrator.
        case adminPolicyEnforced = "admin_policy_enforced"

        /// The authorization endpoint is displayed inside an embedded user-agent disallowed by Google's OAuth 2.0 Policies.
        case disallowedUserAgent = "disallowed_useragent"

        /// The OAuth client ID in the request is part of a project limiting access to Google Accounts in a specific Google Cloud Organization.
        case orgInternal = "org_internal"
        
        /// The OAuth client secret is incorrect. Review the OAuth client configuration, including the client ID and secret used for this request.
        case invalidClient = "invalid_client"
        
        /// When refreshing an access token or using incremental authorization, the token may have expired or has been invalidated.
        case invalidGrant = "invalid_grant"
        
        /// The redirect_uri passed in the authorization request does not match an authorized redirect URI for the OAuth client ID.
        case redirectUriMismatch = "redirect_uri_mismatch"
        
        /// There was something wrong with the request you made. This could be due to a number of reasons.
        case invalidRequest = "invalid_request"
        
        /// Invalid redirect URL
        case invalidRedirectUrl = "invalid_redirect_url"

        case unknown
        
        public var description: String { rawValue }
        
        public init(_ string: String) {
            self = Self(rawValue: string) ?? .unknown
        }
    }
}

extension YouTube.Objects {
    
    public struct OAuthToken: Codable, Hashable {
        
        public var accessToken: String
        public var expiresIn: Double
        public var tokenType: String
        public var scope: String
        public var refreshToken: String?
        
        public init(accessToken: String, expiresIn: Double, tokenType: String, scope: String, refreshToken: String?) {
            self.accessToken = accessToken
            self.expiresIn = expiresIn
            self.tokenType = tokenType
            self.scope = scope
            self.refreshToken = refreshToken
        }
    }
    
    public struct OAuthRefreshedToken: Codable, Hashable {
        
        public var accessToken: String
        public var expiresIn: Double
        public var tokenType: String
        public var scope: String
        
        public init(accessToken: String, expiresIn: Double, tokenType: String, scope: String) {
            self.accessToken = accessToken
            self.expiresIn = expiresIn
            self.tokenType = tokenType
            self.scope = scope
        }
    }
    
    public struct TokenRequest: Codable, Equatable {
        public var clientId: String
        public var clientSecret: String
        public var code: String?
        public var grantType: String
        public var redirectUri: String?
        public var refreshToken: String?
        public var codeVerifier: String?
        
        public init(
            clientId: String,
            clientSecret: String,
            code: String? = nil,
            codeVerifier: String? = nil,
            grantType: String,
            redirectUri: String? = nil,
            refreshToken: String? = nil
        ) {
            self.clientId = clientId
            self.clientSecret = clientSecret
            self.code = code
            self.grantType = grantType
            self.redirectUri = redirectUri
            self.refreshToken = refreshToken
            self.codeVerifier = codeVerifier
        }
    }
}

public extension YouTube.Objects {

    enum AccessType: String, Hashable, Codable, CaseIterable {
        case offline, online
    }

    enum Prompt: String, Hashable, Codable, CaseIterable {
        /// Do not display any authentication or consent screens. Must not be specified with other values.
        case none
        /// Prompt the user for consent.
        case consent
        /// Prompt the user to select an account.
        case selectAccount = "select_account"
    }

    enum CodeChallengeMethod: String, Hashable, Codable, CaseIterable {
        case S256, plain
    }
}

private extension YouTube.OAuth2 {

    func generateCodeChallenge(method: YouTube.Objects.CodeChallengeMethod) -> String? {
        let codeVerifier = generateCodeVerifier()
        self.codeVerifier = codeVerifier
        switch method {
        case .S256:
            guard let data = codeVerifier.data(using: .ascii) else {
                self.codeVerifier = nil
                return nil
            }
            
            let hash = data.sha256()
            let hashData = Data(hash)
            return hashData.base64URLEncodedString()
        case .plain:
            return codeVerifier
        }
    }

    func generateCodeVerifier() -> String {
        let characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~"
        let length = Int.random(in: 43..<129) // Ensure length is between 43 and 128
        var codeVerifier = ""

        for _ in 0..<length {
            if let randomCharacter = characters.randomElement() {
                codeVerifier.append(randomCharacter)
            }
        }
        
        return codeVerifier
    }
}

// Extension to encode data to Base64 URL encoded string
private extension Data {

    func base64URLEncodedString() -> String {
        self.base64EncodedString()
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
    }
}
