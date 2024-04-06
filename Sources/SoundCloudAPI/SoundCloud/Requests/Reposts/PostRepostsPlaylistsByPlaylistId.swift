
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Reposts {

	/**
	 Reposts a playlist as the authenticated user

	 **POST** /reposts/playlists/{playlist_id}
	 */
	func postPlaylistsByPlaylistId(playlistId playlist_id: Int, fileID: String = #fileID, line: UInt = #line) async throws {
		try await client
			.path("/reposts/playlists/\(playlist_id)")
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
