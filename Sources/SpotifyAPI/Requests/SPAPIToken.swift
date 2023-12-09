import Foundation
import SwiftHttp

public extension Spotify.API {

	/// https://developer.spotify.com/documentation/general/guides/authorization/code-flow/
	@discardableResult
	func accessToken(
		code: String,
		redirectURI: String,
		codeVerifier: String? = nil
    ) async throws -> SPTokenResponse {
        let result: SPTokenResponse = try await decodableRequest(
            url: apiBaseURL.path("token"),
            method: .post,
            body: [
                "grant_type": "authorization_code",
                "code": code,
                "redirect_uri": redirectURI,
                "code_verifier": codeVerifier,
            ]
                .compactMapValues { $0?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) }
                .map { "\($0.key)=\($0.value)" }
                .joined(separator: "&")
                .data(using: .utf8),
            headers: headers(
                with: [
                    .contentType: "application/x-www-form-urlencoded",
                    .accept: ""
                ],
                auth: .basic
            )
        )
        refreshToken = result.refreshToken ?? refreshToken
        token = result.accessToken
        return result
    }

	/// https://developer.spotify.com/documentation/general/guides/authorization/code-flow/
	@discardableResult
    func refreshToken() async throws -> SPTokenResponse {
        guard let refreshToken else {
            throw SPError(status: 401, message: "No refresh token")
        }
        let result: SPTokenResponse = try await decodableRequest(
            url: apiBaseURL.path("token"),
            method: .post,
            body: [
                "grant_type": "refresh_token",
                "refresh_token": refreshToken,
            ]
                .compactMapValues { $0.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) }
                .map { "\($0.key)=\($0.value)" }
                .joined(separator: "&")
                .data(using: .utf8),
            headers: headers(
                with: [
                    .contentType: "application/x-www-form-urlencoded",
                    .accept: ""
                ],
                auth: .basic
            )
        )
        token = result.accessToken
        return result
    }

	nonisolated func authenticationURL(
		redirectURI: String,
        showDialog: Bool = true,
        state: String? = nil,
		scope: [Scope]
	) -> HttpUrl {
		var url = HttpUrl(
			host: "accounts.spotify.com",
			path: ["authorize"],
			query: [
				"client_id": clientID,
				"redirect_uri": redirectURI,
				"response_type": "code",
				"show_dialog": "\(showDialog)",
                "state": state
            ].compactMapValues { $0 }
		)
		if !scope.isEmpty {
			url.query["scope"] = scope.map(\.rawValue).joined(separator: " ")
		}
		return url
	}
}
