
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Reposts {

	/**
	 Reposts a track as the authenticated user

	 **POST** /reposts/tracks/{track_id}
	 */
	func postTracksByTrackId(trackId track_id: Int, fileID: String = #fileID, line: UInt = #line) async throws {
		try await client
			.path("/reposts/tracks/\(track_id)")
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
