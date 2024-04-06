
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Users {

	/**
	 Returns a list of user’s followers.

	 Returns a list of users that follows (user_id).

	 **GET** /users/{user_id}/followers
	 */
	func getByUserIdFollowers(userId user_id: Int, limit: Int? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> Users {
		try await client
			.path("/users/\(user_id)/followers")
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
