
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Tracks {

	/**
	 Returns a list of users who have favorited or liked the track.

	 **GET** /tracks/{track_id}/favoriters
	 */
	func getByTrackIdFavoriters(trackId track_id: Int, limit: Int? = nil, linkedPartitioning: Bool? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> Users {
		try await client
			.path("/tracks/\(track_id)/favoriters")
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
