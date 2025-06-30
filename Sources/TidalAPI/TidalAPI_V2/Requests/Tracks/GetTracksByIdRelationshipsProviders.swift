
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension TidalAPI_V2.Tracks {

	/**
	 Get providers relationship ("to-many").

	 Retrieves providers relationship.

	 **GET** /tracks/{id}/relationships/providers
	 */
	func getByIdRelationshipsProviders(id: String, countryCode: String, include: [String]? = nil, pageCursor: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.TracksMultiDataRelationshipDocument {
		try await client
			.path("/tracks/\(id)/relationships/providers")
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
