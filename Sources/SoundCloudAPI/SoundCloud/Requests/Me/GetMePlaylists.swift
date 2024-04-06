
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Me {

	/**
	 Returns user’s playlists (sets).

	 Returns playlist info, playlist tracks and tracks owner info.

	 **GET** /me/playlists
	 */
	func getPlaylists(showTracks: Bool? = nil, linkedPartitioning: Bool? = nil, limit: Int? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> Status200 {
		try await client
			.path("/me/playlists")
			.method(.get)
			.query([
				"show_tracks": showTracks,
				"linked_partitioning": linkedPartitioning,
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
