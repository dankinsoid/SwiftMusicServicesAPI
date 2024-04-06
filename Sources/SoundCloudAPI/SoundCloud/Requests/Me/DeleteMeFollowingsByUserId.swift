
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Me {

	/**
	 Deletes a user who is followed by the authenticated user.

	 **DELETE** /me/followings/{user_id}
	 */
	func deleteFollowingsByUserId(userId user_id: Int, fileID: String = #fileID, line: UInt = #line) async throws {
		try await client
			.path("/me/followings/\(user_id)")
			.method(.delete)
			.auth(enabled: true)
			.call(
				.http,
				as: .void,
				fileID: fileID,
				line: line
			)
	}
}
