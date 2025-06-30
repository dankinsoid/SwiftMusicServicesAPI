
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension TidalAPI_V2.Playlists {

	/**
	 Get coverArt relationship ("to-many").

	 Retrieves coverArt relationship.

	 **GET** /playlists/{id}/relationships/coverArt
	 */
	func getByIdRelationshipsCoverArt(id: String, countryCode: String, include: [String]? = nil, pageCursor: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.PlaylistsMultiDataRelationshipDocument {
		try await client
			.path("/playlists/\(id)/relationships/coverArt")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"include": include,
				"page[cursor]": pageCursor,
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
