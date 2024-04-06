
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Reposts {

	/**
	 Removes a repost on a track as the authenticated user

	 **DELETE** /reposts/tracks/{track_id}
	 */
	func deleteTracksByTrackId(trackId track_id: Int, fileID: String = #fileID, line: UInt = #line) async throws {
		try await client
			.path("/reposts/tracks/\(track_id)")
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
