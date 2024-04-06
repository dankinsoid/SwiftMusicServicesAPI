
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Me {

	/**
	 Returns a list of favorited or liked tracks of the authenticated user.

	 **GET** /me/likes/tracks
	 */
	func getLikesTracks(limit: Int? = nil, access: [Access]? = nil, linkedPartitioning: Bool? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> OneOf<Tracks, TracksList> {
		try await client
			.path("/me/likes/tracks")
			.method(.get)
			.query([
				"limit": limit,
				"access": access,
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

	enum GetMeLikesTracks {}
}
