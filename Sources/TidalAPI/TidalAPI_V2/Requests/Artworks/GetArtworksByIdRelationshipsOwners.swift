
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension TidalAPI_V2.Artworks {

	/**
	 Get owners relationship ("to-many").

	 Retrieves owners relationship.

	 **GET** /artworks/{id}/relationships/owners
	 */
	func getByIdRelationshipsOwners(id: String, include: [String]? = nil, pageCursor: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.ArtworksMultiDataRelationshipDocument {
		try await client
			.path("/artworks/\(id)/relationships/owners")
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
