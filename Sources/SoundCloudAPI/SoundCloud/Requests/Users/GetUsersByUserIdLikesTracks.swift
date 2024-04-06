
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Users {

	/**
	 Returns a list of user's liked tracks.

	 **GET** /users/{user_id}/likes/tracks
	 */
	func getByUserIdLikesTracks(userId user_id: Int, access: [Access]? = nil, limit: Int? = nil, linkedPartitioning: Bool? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> Status200 {
		try await client
			.path("/users/\(user_id)/likes/tracks")
			.method(.get)
			.query([
				"access": access,
				"limit": limit,
				"linked_partitioning": linkedPartitioning,
			])
			.auth(enabled: true)
			.call(
				.http,
				as: .decodable,
				fileID: fileID,
				line: line
			)
	}

	enum GetUsersByUserIdLikesTracks {}
}
