
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Tracks {

	/**
	 Deletes a track.

	 **DELETE** /tracks/{track_id}
	 */
	func deleteByTrackId(trackId track_id: Int, fileID: String = #fileID, line: UInt = #line) async throws {
		try await client
			.path("/tracks/\(track_id)")
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
