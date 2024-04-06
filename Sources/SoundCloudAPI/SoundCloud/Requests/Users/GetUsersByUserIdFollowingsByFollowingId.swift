
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Users {

	/**
	 Returns a user's following. (use /users/{user_id} instead, to fetch the user details)

	 Returns (following_id) that is followed by (user_id).

	 **GET** /users/{user_id}/followings/{following_id}
	 */
	func getByUserIdFollowingsByFollowingId(userId user_id: Int, followingId following_id: Int, fileID: String = #fileID, line: UInt = #line) async throws -> User {
		try await client
			.path("/users/\(user_id)/followings/\(following_id)")
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
