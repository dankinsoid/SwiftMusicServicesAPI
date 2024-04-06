
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Oauth {

	/**
	 This endpoint accepts POST requests and is used to provision access tokens once a user has authorized your application.

	 **POST** /oauth2/token
	 */
	func post2Token(fileID: String = #fileID, line: UInt = #line) async throws {
		try await client
			.path("/oauth2/token")
			.method(.post)
			.auth(enabled: false)
			.call(
				.http,
				as: .void,
				fileID: fileID,
				line: line
			)
	}
}
