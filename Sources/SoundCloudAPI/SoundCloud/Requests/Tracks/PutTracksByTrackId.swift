
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Tracks {

	/**
	 Updates a track's information.

	 **PUT** /tracks/{track_id}
	 */
	func putByTrackId(trackId track_id: Int, body: TrackMetadataRequest? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> Track {
		try await client
			.path("/tracks/\(track_id)")
			.method(.put)
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
