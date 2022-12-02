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
			executor: client.dataTask,
			url: apiBaseURL.path("token").query(
				[
					"grant_type": "authorization_code",
					"code": code,
					"redirect_uri": redirectURI,
					"client_id": clientID,
					"code_verifier": codeVerifier
				]
			),
			method: .post,
			headers: headers(
				with: [
					.contentType: "application/x-www-form-urlencoded"
				],
				auth: .clientBase64
			)
		)
		refreshToken = result.refreshToken ?? refreshToken
		token = result.accessToken
		return result
	}

	/// https://developer.spotify.com/documentation/general/guides/authorization/code-flow/
	@discardableResult
	func refreshToken() async throws -> SPTokenResponse {
		guard let refreshToken = refreshToken else {
			throw SPError(status: 401, message: "No refresh token")
		}
		let result: SPTokenResponse = try await decodableRequest(
			executor: client.dataTask,
			url: apiBaseURL.path("token").query(
				[
					"grant_type": "refresh_token",
					"refresh_token": refreshToken,
					"client_id": clientID
				]
			),
			method: .post,
			headers: headers(
				with: [
					.contentType: "application/x-www-form-urlencoded"
				],
				auth: .clientBase64
			)
		)
		token = result.accessToken
		return result
	}
}
