
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension TidalAPI_V2.Tracks {

	/**
	 Get radio relationship ("to-many").

	 Retrieves radio relationship.

	 **GET** /tracks/{id}/relationships/radio
	 */
	func getByIdRelationshipsRadio(id: String, include: [String]? = nil, pageCursor: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.TracksMultiDataRelationshipDocument {
		try await client
			.path("/tracks/\(id)/relationships/radio")
			.method(.get)
			.query([
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
