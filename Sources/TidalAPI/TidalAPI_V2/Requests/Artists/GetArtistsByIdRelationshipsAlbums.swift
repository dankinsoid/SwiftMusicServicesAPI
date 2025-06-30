
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension TidalAPI_V2.Artists {

	/**
	 Get albums relationship ("to-many").

	 Retrieves albums relationship.

	 **GET** /artists/{id}/relationships/albums
	 */
	func getByIdRelationshipsAlbums(id: String, countryCode: String, pageCursor: String? = nil, include: [String]? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.ArtistsMultiDataRelationshipDocument {
		try await client
			.path("/artists/\(id)/relationships/albums")
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
