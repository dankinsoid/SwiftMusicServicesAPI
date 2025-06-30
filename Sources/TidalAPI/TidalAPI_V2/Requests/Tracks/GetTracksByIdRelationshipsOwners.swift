
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension TidalAPI_V2.Tracks {

	/**
	 Get owners relationship ("to-many").

	 Retrieves owners relationship.

	 **GET** /tracks/{id}/relationships/owners
	 */
	func getByIdRelationshipsOwners(id: String, include: [String]? = nil, pageCursor: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.TracksMultiDataRelationshipDocument {
		try await client
			.path("/tracks/\(id)/relationships/owners")
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
