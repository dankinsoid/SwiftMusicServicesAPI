import Foundation
import SwiftAPIClient
import SwiftMusicServicesApi

public extension Spotify.API {

	/// https://developer.spotify.com/documentation/general/guides/authorization/code-flow/
	@discardableResult
	func accessToken(
		code: String,
		redirectURI: String
    ) async throws -> SPTokenResponse {
        let result: SPTokenResponse = try await clientWithoutTokenRefresher
            .url(apiBaseURL)
            .path("token")
            .bodyEncoder(.formURL)
            .body([
                "grant_type": "authorization_code",
                "code": code,
                "redirect_uri": redirectURI,
                "code_verifier": codeVerifier,
            ])
            .headers(.accept(""), removeCurrent: true)
            .auth(basicAuth)
            .post()
        codeVerifier = nil
        if let refreshToken = result.refreshToken {
            try? await cache.save(refreshToken, for: .refreshToken)
        }
        try? await cache.save(result.accessToken, for: .accessToken)
        try? await cache.save(Date(timeIntervalSinceNow: result.expiresIn), for: .expiryDate)
        return result
    }

    func authenticationURL(
		redirectURI: String,
        showDialog: Bool = true,
        state: String? = nil,
		scope: [Scope],
        codeChallengeMethod: CodeChallengeMethod? = nil
    ) -> URL? {
        let scopeStrings = scope.map { $0.rawValue }

        var params = [
            "client_id": clientID,
            "redirect_uri": redirectURI,
            "response_type": "code",
            "show_dialog": "\(showDialog)",
            "nosignup": "true",
            "nolinks": "true"
        ]

        if scopeStrings.count > 0 {
            params["scope"] = scopeStrings.joined(separator: " ")
        }
        if let state {
            params["state"] = state
        }
        if let codeChallengeMethod, let (verifier, challenge) = generateCodeChallenge(method: codeChallengeMethod) {
            codeVerifier = verifier
            params["code_challenge"] = challenge
            params["code_challenge_method"] = codeChallengeMethod.rawValue
        } else {
            codeVerifier = nil
        }

        let loginPageURLString = "https://accounts.spotify.com/authorize?\(String.query(params: params))"
        return URL(string: loginPageURLString)
	}
}
