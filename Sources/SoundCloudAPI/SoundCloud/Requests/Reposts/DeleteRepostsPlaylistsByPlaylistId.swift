
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Reposts {

	/**
	 Removes a repost on a playlist as the authenticated user

	 **DELETE** /reposts/playlists/{playlist_id}
	 */
	func deletePlaylistsByPlaylistId(playlistId playlist_id: Int, fileID: String = #fileID, line: UInt = #line) async throws {
		try await client
			.path("/reposts/playlists/\(playlist_id)")
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
