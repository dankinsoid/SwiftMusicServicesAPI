
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.Playlists {

	/**
	 Delete single playlist.

	 Deletes existing playlist.

	 **DELETE** /playlists/{id}
	 */
	func deleteById(id: String, fileID: String = #fileID, line: UInt = #line) async throws {
		try await client
			.path("/playlists/\(id)")
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
