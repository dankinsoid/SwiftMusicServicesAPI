
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension TidalAPI_V2.SearchResults {

	/**
	 Get single searchResult.

	 Retrieves single searchResult by id.

	 **GET** /searchResults/{id}
	 */
	func getById(id: String, countryCode: String, explicitFilter: String? = nil, include: [String]? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.SearchResultsSingleDataDocument {
		try await client
			.path("/searchResults/\(id)")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"explicitFilter": explicitFilter,
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
