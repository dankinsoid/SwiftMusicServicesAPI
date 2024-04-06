
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Tracks {

	/**
	 Returns a collection of track's reposters.

	 **GET** /tracks/{track_id}/reposters
	 */
	func getByTrackIdReposters(trackId track_id: Int, limit: Int? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> Users {
		try await client
			.path("/tracks/\(track_id)/reposters")
			.method(.get)
			.query([
				"limit": limit,
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
