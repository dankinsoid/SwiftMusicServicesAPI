
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension TidalAPI_V2.Playlists {

	/**
	 Create single playlist.

	 Creates a new playlist.

	 **POST** /playlists
	 */
	func post(countryCode: String, body: TDO.PlaylistCreateOperationPayload, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.PlaylistsSingleDataDocument {
		try await client
			.path("/playlists")
			.method(.post)
			.body(body)
			.query([
				"countryCode": countryCode,
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
