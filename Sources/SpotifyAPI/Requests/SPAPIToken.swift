import Foundation
import SwiftAPIClient

public extension Spotify.API {

	/// https://developer.spotify.com/documentation/general/guides/authorization/code-flow/
	@discardableResult
	func accessToken(
		code: String,
		redirectURI: String,
		codeVerifier: String? = nil
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
		scope: [Scope]
    ) -> URL {
        URL(
            string: "https://accounts.spotify.com/authorize/?client_id=\(clientID)&redirect_uri=\(redirectURI)&response_type=code&show_dialog=\(showDialog)&state=\(state ?? "")\(scope.isEmpty ? "" : "&scope=\(scope.map(\.rawValue).joined(separator: " "))")"
        )!
	}
}
