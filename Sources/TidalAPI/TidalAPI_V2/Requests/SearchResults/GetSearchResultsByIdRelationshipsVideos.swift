
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension TidalAPI_V2.SearchResults {

	/**
	 Get videos relationship ("to-many").

	 Retrieves videos relationship.

	 **GET** /searchResults/{id}/relationships/videos
	 */
	func getByIdRelationshipsVideos(id: String, countryCode: String, explicitFilter: String? = nil, include: [String]? = nil, pageCursor: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.SearchResultsMultiDataRelationshipDocument {
		try await client
			.path("/searchResults/\(id)/relationships/videos")
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
