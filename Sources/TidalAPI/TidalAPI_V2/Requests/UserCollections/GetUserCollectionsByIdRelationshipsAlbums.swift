
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension TidalAPI_V2.UserCollections {

	/**
	 Get albums relationship ("to-many").

	 Retrieves albums relationship.

	 **GET** /userCollections/{id}/relationships/albums
	 */
	func getByIdRelationshipsAlbums(id: String, countryCode: String, locale: String, pageCursor: String? = nil, include: [String]? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.UserCollectionsAlbumsMultiDataRelationshipDocument {
		try await client
			.path("/userCollections/\(id)/relationships/albums")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"locale": locale,
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
