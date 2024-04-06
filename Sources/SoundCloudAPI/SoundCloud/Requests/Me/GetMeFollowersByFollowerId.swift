
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Me {

	/**
	 Returns a user who is following the authenticated user. (use /users/{user_id} instead, to fetch the user details)

	 **GET** /me/followers/{follower_id}
	 */
	func getFollowersByFollowerId(followerId follower_id: Int, fileID: String = #fileID, line: UInt = #line) async throws -> User {
		try await client
			.path("/me/followers/\(follower_id)")
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
