
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Playlists {

	/**
	 Returns tracks under a playlist.

	 **GET** /playlists/{playlist_id}/tracks
	 */
	func getByPlaylistIdTracks(playlistId playlist_id: Int, secretToken: String? = nil, access: [Access]? = nil, linkedPartitioning: Bool? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> OneOf<Tracks, TracksList> {
		try await client
			.path("/playlists/\(playlist_id)/tracks")
			.method(.get)
			.query([
				"secret_token": secretToken,
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

	enum GetPlaylistsByPlaylistIdTracks {}
}
