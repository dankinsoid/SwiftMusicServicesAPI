
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Likes {

	/**
	 Unlikes a playlist.

	 **DELETE** /likes/playlists/{playlist_id}
	 */
	func deletePlaylistsByPlaylistId(playlistId playlist_id: Int, fileID: String = #fileID, line: UInt = #line) async throws {
		try await client
			.path("/likes/playlists/\(playlist_id)")
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
