
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Users {

	/**
	 Returns a list of user's liked playlists.

	 **GET** /users/{user_id}/likes/playlists
	 */
	func getByUserIdLikesPlaylists(userId user_id: Int, limit: Int? = nil, linkedPartitioning: Bool? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> Status200 {
		try await client
			.path("/users/\(user_id)/likes/playlists")
			.method(.get)
			.query([
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
}
