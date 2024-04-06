
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Oauth {

	/**
	     The OAuth2 authorization endpoint. Your app redirects a user to this endpoint, allowing them to delegate access to their account.

	     <h3>Security Advice</h3>
	 * [OAuth Authorization Code flow](https://datatracker.ietf.org/doc/html/draft-ietf-oauth-security-topics-16#section-2.1.1) (`response_type=code`) is the only allowed method of authorization.
	 * Use the `state` parameter for [CSRF protection](https://tools.ietf.org/html/draft-ietf-oauth-security-topics-16#section-4.7). Pass a sufficient  random nonce here and verify this nonce again after retrieving the token.

	     **GET** /connect
	     */
	func getConnect(clientId: String, redirectUri: String, responseType: ResponseType, state: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws {
		try await client
			.path("/connect")
			.method(.get)
			.query([
				"client_id": clientId,
				"redirect_uri": redirectUri,
				"response_type": responseType,
				"state": state,
			])
			.auth(enabled: false)
			.call(
				.http,
				as: .void,
				fileID: fileID,
				line: line
			)
	}

	enum GetConnect {}
}
