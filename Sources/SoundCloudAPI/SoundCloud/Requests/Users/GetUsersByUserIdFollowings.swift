
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Users {

	/**
	 Returns a list of user’s followings.

	 Returns list of users that (user_id) follows.

	 **GET** /users/{user_id}/followings
	 */
	func getByUserIdFollowings(userId user_id: Int, limit: Int? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> Users {
		try await client
			.path("/users/\(user_id)/followings")
			.method(.get)
			.query([
				"limit": limit,
			])
			.auth(enabled: true)
			.call(
				.http,
				as: .decodable,
				fileID: fileID,
				line: line
			)
	}
}
