
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Tracks {

	/**
	 Uploads a new track.

	 **POST** /tracks
	 */
	func post(fileID: String = #fileID, line: UInt = #line) async throws -> Track {
		try await client
			.path("/tracks")
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
