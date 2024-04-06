
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Tracks {

	/**
	 Returns the newly created comment on success

	 **POST** /tracks/{track_id}/comments
	 */
	func postByTrackIdComments(trackId track_id: Int, fileID: String = #fileID, line: UInt = #line) async throws -> Comment {
		try await client
			.path("/tracks/\(track_id)/comments")
			.method(.post)
			.auth(enabled: true)
			.call(
				.http,
				as: .decodable,
				fileID: fileID,
				line: line
			)
	}
}
