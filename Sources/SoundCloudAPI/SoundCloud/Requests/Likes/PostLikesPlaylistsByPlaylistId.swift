
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Likes {

	/**
	 Likes a playlist.

	 **POST** /likes/playlists/{playlist_id}
	 */
	func postPlaylistsByPlaylistId(playlistId playlist_id: Int, fileID: String = #fileID, line: UInt = #line) async throws {
		try await client
			.path("/likes/playlists/\(playlist_id)")
			.method(.post)
			.auth(enabled: true)
			.call(
				.http,
				as: .void,
				fileID: fileID,
				line: line
			)
	}
}
