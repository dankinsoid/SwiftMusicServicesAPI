
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension TidalAPI_V2.Artists {

	/**
	 Get profileArt relationship ("to-many").

	 Retrieves profileArt relationship.

	 **GET** /artists/{id}/relationships/profileArt
	 */
	func getByIdRelationshipsProfileArt(id: String, countryCode: String, include: [String]? = nil, pageCursor: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.ArtistsMultiDataRelationshipDocument {
		try await client
			.path("/artists/\(id)/relationships/profileArt")
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
