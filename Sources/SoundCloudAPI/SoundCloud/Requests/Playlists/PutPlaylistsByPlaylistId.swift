
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Playlists {

	/**
	 Updates a playlist.

	 **PUT** /playlists/{playlist_id}
	 */
	func putByPlaylistId(playlistId playlist_id: Int, body: CreateUpdatePlaylistRequest? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> Playlist {
		try await client
			.path("/playlists/\(playlist_id)")
			.method(.put)
			.auth(enabled: true)
			.body(body)
			.call(
				.http,
				as: .decodable,
				fileID: fileID,
				line: line
			)
	}
}
