
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension TidalAPI_V2.SearchResults {

	/**
	 Get tracks relationship ("to-many").

	 Retrieves tracks relationship.

	 **GET** /searchResults/{id}/relationships/tracks
	 */
	func getByIdRelationshipsTracks(id: String, countryCode: String, explicitFilter: String? = nil, include: [String]? = nil, pageCursor: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.SearchResultsMultiDataRelationshipDocument {
		try await client
			.path("/searchResults/\(id)/relationships/tracks")
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
