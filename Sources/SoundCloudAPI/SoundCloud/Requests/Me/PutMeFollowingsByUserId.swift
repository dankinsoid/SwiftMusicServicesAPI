
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Me {

	/**
	 Follows a user.

	 **PUT** /me/followings/{user_id}
	 */
	func putFollowingsByUserId(userId user_id: Int, fileID: String = #fileID, line: UInt = #line) async throws {
		try await client
			.path("/me/followings/\(user_id)")
			.method(.put)
			.auth(enabled: true)
			.call(
				.http,
				as: .void,
				fileID: fileID,
				line: line
			)
	}
}
