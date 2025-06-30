
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension TidalAPI_V2.Playlists {

	/**
	 Get single playlist.

	 Retrieves single playlist by id.

	 **GET** /playlists/{id}
	 */
	func getById(id: String, countryCode: String, include: [String]? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.PlaylistsSingleDataDocument {
		try await client
			.path("/playlists/\(id)")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"include": include,
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
