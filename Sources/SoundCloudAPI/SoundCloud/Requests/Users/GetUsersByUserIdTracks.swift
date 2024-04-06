
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Users {

	/**
	 Returns a list of user's tracks.

	 **GET** /users/{user_id}/tracks
	 */
	func getByUserIdTracks(userId user_id: Int, access: [Access]? = nil, limit: Int? = nil, linkedPartitioning: Bool? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> Status200 {
		try await client
			.path("/users/\(user_id)/tracks")
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

	enum GetUsersByUserIdTracks {}
}
