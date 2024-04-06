
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Tracks {

	/**
	 Returns all related tracks of track on SoundCloud.

	 **GET** /tracks/{track_id}/related
	 */
	func getByTrackIdRelated(trackId track_id: Int, access: [Access]? = nil, limit: Int? = nil, offset: Int? = nil, linkedPartitioning: Bool? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> OneOf<Tracks, TracksList> {
		try await client
			.path("/tracks/\(track_id)/related")
			.method(.get)
			.query([
				"access": access,
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

	enum GetTracksByTrackIdRelated {}
}
