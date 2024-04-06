
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Likes {

	/**
	 Unlikes a track.

	 **DELETE** /likes/tracks/{track_id}
	 */
	func deleteTracksByTrackId(trackId track_id: Int, fileID: String = #fileID, line: UInt = #line) async throws {
		try await client
			.path("/likes/tracks/\(track_id)")
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
