
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension TidalAPI_V2.Artists {

	/**
	 Get tracks relationship ("to-many").

	 Retrieves tracks relationship.

	 **GET** /artists/{id}/relationships/tracks
	 */
	func getByIdRelationshipsTracks(id: String, countryCode: String, collapseBy: String, pageCursor: String? = nil, include: [String]? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.ArtistsMultiDataRelationshipDocument {
		try await client
			.path("/artists/\(id)/relationships/tracks")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"collapseBy": collapseBy,
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
