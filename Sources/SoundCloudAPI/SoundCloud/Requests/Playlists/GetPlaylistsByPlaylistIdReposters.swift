
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Playlists {

	/**
	 Returns a collection of playlist's reposters.

	 **GET** /playlists/{playlist_id}/reposters
	 */
	func getByPlaylistIdReposters(playlistId playlist_id: Int, limit: Int? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> Users {
		try await client
			.path("/playlists/\(playlist_id)/reposters")
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
