import Foundation

public extension SoundCloud.Objects {
    
    struct OAuthToken: Codable, Hashable {
        
        public var accessToken: String
        public var refreshToken: String?
        public var expiresIn: Double?
        public var tokenType: String?
        public var scope: String?
        
        public init(accessToken: String, refreshToken: String? = nil, expiresIn: Double? = nil, tokenType: String? = nil, scope: String? = nil) {
            self.accessToken = accessToken
            self.refreshToken = refreshToken
            self.expiresIn = expiresIn
            self.tokenType = tokenType
            self.scope = scope
        }
    }
    
    struct AuthorizeRequest: Codable, Equatable {
        
        public var responseType: String
        public var redirectUri: String
        public var state: String?
        public var codeChallenge: String?
        public var codeChallengeMethod: String?
        public var clientId: String
        
        public init(
            clientId: String,
            responseType: String,
            redirectUri: String,
            state: String? = nil,
            codeChallenge: String? = nil,
            codeChallengeMethod: String? = nil
        ) {
            self.clientId = clientId
            self.responseType = responseType
            self.redirectUri = redirectUri
            self.state = state
            self.codeChallenge = codeChallenge
            self.codeChallengeMethod = codeChallengeMethod
        }
    }
    
    struct TokenRequest: Codable, Equatable {

        public var clientId: String
        public var code: String?
        public var grantType: String
        public var redirectUri: String?
        public var refreshToken: String?
        public var codeVerifier: String?
        
        public init(
            clientId: String,
            code: String? = nil,
            codeVerifier: String? = nil,
            grantType: String,
            redirectUri: String? = nil,
            refreshToken: String? = nil
        ) {
            self.clientId = clientId
            self.code = code
            self.grantType = grantType
            self.redirectUri = redirectUri
            self.refreshToken = refreshToken
            self.codeVerifier = codeVerifier
        }
    }
}
