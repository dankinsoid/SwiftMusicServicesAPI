
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.Playlists {

	/**
	 Update single playlist.

	 Updates existing playlist.

	 **PATCH** /playlists/{id}
	 */
	func patchById(id: String, countryCode: String? = nil, body: TDO.PlaylistUpdateOperationPayload, fileID: String = #fileID, line: UInt = #line) async throws {
		try await client
			.path("/playlists/\(id)")
			.method(.patch)
			.body(body)
			.query([
				"countryCode": countryCode,
			])
			.auth(enabled: true)
			.call(
				.http,
				as: .void,
				fileID: fileID,
				line: line
			)
	}
}
