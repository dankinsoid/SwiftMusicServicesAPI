import Foundation
import SwiftAPIClient
@_exported import SwiftMusicServicesApi

public extension SoundCloud {
    
    final class OAuth2 {
        
        public static let desktopWebRedirectURI = "https://soundcloud.com/signin/callback"
        public static let mobileWebRedirectURI = "https://m.soundcloud.com/signin/callback"
        
        package var onLogin: ((Result<SCO.OAuthToken, Swift.Error>) -> Void)?
        public let clientID: String
        public let redirectURI: String
        public var codeVerifier: String? {
            get { lock.withReaderLock { _codeVerifier } }
            set { lock.withWriterLockVoid { _codeVerifier = newValue } }
        }
        private var _codeVerifier: String?
        private let lock = ReadWriteLock()
        
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
            clientID: String = SoundCloud.API.desktopWebClientID,
            redirectURI: String = OAuth2.desktopWebRedirectURI
        ) {
            self.client = client.url("https://secure.soundcloud.com/oauth")
                .bodyEncoder(.formURL(keyEncodingStrategy: .convertToSnakeCase))
                .bodyDecoder(.json(keyDecodingStrategy: .convertFromSnakeCase))
                .errorDecoder(.decodable(SCO.Error.self))
                .httpResponseValidator(.statusCode)
                .finalizeRequest { req, _ in
                    req = req.query("client_id", clientID)
                }
            self.clientID = clientID
            self.redirectURI = redirectURI
        }
        
        /// OAuth 2.0
        ///
        /// - Parameters:
        ///   - responseType: Determines whether the OAuth 2.0 endpoint returns an authorization code. Set the parameter value to `code` for web server applications.
        ///   - accessType: Recommended. Indicates whether your application can refresh access tokens when the user is not present at the browser. Valid parameter values are online, which is the default value, and offline.
        ///   Set the value to offline if your application needs to refresh access tokens when the user is not present at the browser. This is the method of refreshing access tokens described later in this document.
        ///   This value instructs the Google authorization server to return a refresh token and an access token the first time that your application exchanges an authorization code for tokens.
        ///   - state: Specifies any string value that your application uses to maintain state between your authorization request and the authorization server's response.
        ///   The server returns the exact value that you send as a name=value pair in the URL query component (?) of the redirect_uri after the user consents to or denies your application's access request.
        ///   The only supported values for this parameter are S256 or plain. When nil PKCE auth is not used.   .
        public func authorize(
            responseType: String = "code",
            state: String? = nil,
            codeChallengeMethod: CodeChallengeMethod? = nil
        ) {
            let code_challenge: String?
            if let codeChallengeMethod, let (verifier, challenge) = generateCodeChallenge(method: codeChallengeMethod) {
                codeVerifier = verifier
                code_challenge = challenge
            } else {
                codeVerifier = nil
                code_challenge = nil
            }
            client.url("https://api-auth.soundcloud.com/oauth/authorize")
                .bodyEncoder(.json(keyEncodingStrategy: .convertToSnakeCase))
                .body(SCO.AuthorizeRequest(
                    clientId: clientID,
                    responseType: responseType,
                    redirectUri: redirectURI,
                    state: state,
                    codeChallenge: code_challenge,
                    codeChallengeMethod: codeChallengeMethod?.rawValue
                ))
                .post
        }

        public func authURL(
            responseType: String = "code",
            state: String? = nil,
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
            //
            return APIClient(string: "https://secure.soundcloud.com/web-auth")
                .query(SCO.AuthorizeRequest(
                    clientId: clientID,
                    responseType: responseType,
                    redirectUri: redirectURI,
                    state: state,
                    codeChallenge: code_challenge,
                    codeChallengeMethod: codeChallengeMethod?.rawValue
                ))
                .query([
                    "deviceId": "842494-682961-9227-91727",
                    "origin": "https://m.soundcloud.com",
                    "theme": "prefers-color-scheme",
                    "uiEvo": true,
                    "appId": 65097,
                    "tracking": "local"
                ])
                .url
        }
        
        /// - Returns: An auth code.
        /// - Throws: ``SCO.Auth.Error``
        public func codeFrom(redirected url: String) throws -> String? {
            guard let components = URLComponents(string: url) else { return nil }
            let items = components.queryItems ?? []
            if let value = items.first(where: { $0.name == "code" })?.value {
                return value
            } else if let error = items.first(where: { $0.name == "error" })?.value {
                throw AnyError(error)
            } else {
                return nil
            }
        }
        
        @discardableResult
        public func token(code: String, cache: SecureCacheService) async throws -> SCO.OAuthToken {
            do {
                let result: SCO.OAuthToken = try await client("token")
                    .body(
                        SCO.TokenRequest(
                            clientId: clientID,
                            code: code,
                            codeVerifier: codeVerifier,
                            grantType: "authorization_code",
                            redirectUri: redirectURI
                        )
                    )
                    .query("grant_type", "authorization_code")
                    .post()
                codeVerifier = nil
                try? await cache.save(result.accessToken, for: .accessToken)
                if let refreshToken = result.refreshToken {
                    try? await cache.save(refreshToken, for: .refreshToken)
                }
                if let expiresIn = result.expiresIn {
                    try? await cache.save(Date(timeIntervalSinceNow: expiresIn), for: .expiryDate)
                }
                onLogin?(.success(result))
                return result
            } catch {
                onLogin?(.failure(error))
                throw error
            }
        }
        
        //        public func refreshToken(_ refreshToken: String) async throws -> YTO.OAuthRefreshedToken {
        //            try await client.url("https://secure.soundcloud.com/oauth/token")
        //                .body(
        //                    YTO.TokenRequest(
        //                        clientId: clientID,
        //                        clientSecret: clientSecret,
        //                        grantType: "refresh_token",
        //                        refreshToken: refreshToken
        //                    )
        //                )
        //                .post()
        //        }
    }
}
