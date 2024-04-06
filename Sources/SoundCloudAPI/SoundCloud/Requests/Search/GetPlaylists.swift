
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Search {

	/**
	 Performs a playlist search based on a query

	 **GET** /playlists
	 */
	func getPlaylists(q: String? = nil, access: [Access]? = nil, showTracks: Bool? = nil, limit: Int? = nil, offset: Int? = nil, linkedPartitioning: Bool? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> Status200 {
		try await client
			.path("/playlists")
			.method(.get)
			.query([
				"q": q,
				"access": access,
				"show_tracks": showTracks,
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

	enum GetPlaylists {}
}
