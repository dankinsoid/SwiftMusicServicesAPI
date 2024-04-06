
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Me {

	/**
	 Returns a user who is followed by the authenticated user. (use /users/{user_id} instead, to fetch the user details)

	 **GET** /me/followings/{user_id}
	 */
	func getFollowingsByUserId(userId user_id: Int, fileID: String = #fileID, line: UInt = #line) async throws -> User {
		try await client
			.path("/me/followings/\(user_id)")
			.method(.get)
			.auth(enabled: true)
			.call(
				.http,
				as: .decodable,
				fileID: fileID,
				line: line
			)
	}
}
