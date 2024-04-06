
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Tracks {

	/**
	 Returns a track.

	 **GET** /tracks/{track_id}
	 */
	func getByTrackId(trackId track_id: Int, secretToken: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> Track {
		try await client
			.path("/tracks/\(track_id)")
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
