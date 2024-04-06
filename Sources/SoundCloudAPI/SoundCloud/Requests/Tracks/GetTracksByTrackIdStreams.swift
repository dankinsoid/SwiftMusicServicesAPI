
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Tracks {

	/**
	 Returns a track's streamable URLs

	 **GET** /tracks/{track_id}/streams
	 */
	func getByTrackIdStreams(trackId track_id: Int, secretToken: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> Streams {
		try await client
			.path("/tracks/\(track_id)/streams")
			.method(.get)
			.query([
				"secret_token": secretToken,
			])
			.auth(enabled: true)
			.call(
				.http,
				as: .decodable,
				fileID: fileID,
				line: line
			)
	}
}
