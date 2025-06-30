
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension TidalAPI_V2.UserCollections {

	/**
	 Get playlists relationship ("to-many").

	 Retrieves playlists relationship.

	 **GET** /userCollections/{id}/relationships/playlists
	 */
	func getByIdRelationshipsPlaylists(id: String, countryCode: String, pageCursor: String? = nil, include: [String]? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.UserCollectionsPlaylistsMultiDataRelationshipDocument {
		try await client
			.path("/userCollections/\(id)/relationships/playlists")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"page[cursor]": pageCursor,
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
