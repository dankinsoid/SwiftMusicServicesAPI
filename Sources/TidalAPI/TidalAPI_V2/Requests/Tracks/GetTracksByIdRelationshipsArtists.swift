
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension TidalAPI_V2.Tracks {

	/**
	 Get artists relationship ("to-many").

	 Retrieves artists relationship.

	 **GET** /tracks/{id}/relationships/artists
	 */
	func getByIdRelationshipsArtists(id: String, countryCode: String, pageCursor: String? = nil, include: [String]? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.TracksMultiDataRelationshipDocument {
		try await client
			.path("/tracks/\(id)/relationships/artists")
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
