
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.SearchResults {

	/**
	 Get topHits relationship ("to-many").

	 Retrieves topHits relationship.

	 **GET** /searchResults/{id}/relationships/topHits
	 */
	func getByIdRelationshipsTopHits(id: String, countryCode: String? = nil, explicitFilter: String? = nil, include: [String]? = nil, pageCursor: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.SearchResultsMultiDataRelationshipDocument {
		try await client
			.path("/searchResults/\(id)/relationships/topHits")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"explicitFilter": explicitFilter,
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
