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
			url: apiBaseURL.path("token").query(
				[
					"grant_type": "authorization_code",
					"code": code,
					"redirect_uri": redirectURI,
					"client_id": clientID,
					"client_secret": clientSecret,
					"code_verifier": codeVerifier,
				]
			),
			method: .post,
			headers: headers(
				with: [
					.contentType: "application/x-www-form-urlencoded",
				],
				auth: nil
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
			url: apiBaseURL.path("token").query(
				[
					"grant_type": "refresh_token",
					"refresh_token": refreshToken,
					"client_id": clientID,
					"client_secret": clientSecret,
				]
			),
			method: .post,
			headers: headers(
				with: [
					.contentType: "application/x-www-form-urlencoded",
				],
				auth: nil
			)
		)
		token = result.accessToken
		return result
	}

	nonisolated func authenticationURL(
		redirectURI: String,
		scope: [Scope]
	) -> HttpUrl {
		var url = HttpUrl(
			host: "accounts.spotify.com",
			path: ["authorize"],
			query: [
				"client_id": clientID,
				"redirect_uri": redirectURI,
				"response_type": "code",
				"show_dialog": "true",
				"nosignup": "true",
				"nolinks": "true",
				"utm_source": "spotify-sdk",
				"utm_medium": "spotifylogin",
				"utm_campaign": "spotifylogin",
			]
		)
		if !scope.isEmpty {
			url.query["scope"] = scope.map(\.rawValue).joined(separator: " ")
		}
		return url
	}
}
