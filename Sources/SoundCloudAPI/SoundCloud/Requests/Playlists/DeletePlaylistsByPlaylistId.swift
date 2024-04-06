
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Playlists {

	/**
	 Deletes a playlist.

	 **DELETE** /playlists/{playlist_id}
	 */
	func deleteByPlaylistId(playlistId playlist_id: Int, fileID: String = #fileID, line: UInt = #line) async throws {
		try await client
			.path("/playlists/\(playlist_id)")
			.method(.delete)
			.auth(enabled: true)
			.call(
				.http,
				as: .void,
				fileID: fileID,
				line: line
			)
	}
}
