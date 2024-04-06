
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Playlists {

	/**
	 Creates a playlist.

	 **POST** /playlists
	 */
	func post(body: CreateUpdatePlaylistRequest? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> Playlist {
		try await client
			.path("/playlists")
			.method(.post)
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
