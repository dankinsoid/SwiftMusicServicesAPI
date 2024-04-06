
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Playlists {

	/**
	 Returns a playlist.

	 **GET** /playlists/{playlist_id}
	 */
	func getByPlaylistId(playlistId playlist_id: Int, secretToken: String? = nil, access: [Access]? = nil, showTracks: Bool? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> Playlist {
		try await client
			.path("/playlists/\(playlist_id)")
			.method(.get)
			.query([
				"secret_token": secretToken,
				"access": access,
				"show_tracks": showTracks,
			])
			.auth(enabled: true)
			.call(
				.http,
				as: .decodable,
				fileID: fileID,
				line: line
			)
	}

	enum GetPlaylistsByPlaylistId {}
}
