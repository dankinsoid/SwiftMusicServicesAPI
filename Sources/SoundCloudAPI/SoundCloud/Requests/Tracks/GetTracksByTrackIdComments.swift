
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Tracks {

	/**
	 Returns the comments posted on the track(track_id).

	 **GET** /tracks/{track_id}/comments
	 */
	func getByTrackIdComments(trackId track_id: Int, limit: Int? = nil, offset: Int? = nil, linkedPartitioning: Bool? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> Comments {
		try await client
			.path("/tracks/\(track_id)/comments")
			.method(.get)
			.query([
				"limit": limit,
				"offset": offset,
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
