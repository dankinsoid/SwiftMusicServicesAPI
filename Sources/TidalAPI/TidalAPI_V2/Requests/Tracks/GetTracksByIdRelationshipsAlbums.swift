
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension TidalAPI_V2.Tracks {

	/**
	 Get albums relationship ("to-many").

	 Retrieves albums relationship.

	 **GET** /tracks/{id}/relationships/albums
	 */
	func getByIdRelationshipsAlbums(id: String, countryCode: String, include: [String]? = nil, pageCursor: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.TracksMultiDataRelationshipDocument {
		try await client
			.path("/tracks/\(id)/relationships/albums")
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
