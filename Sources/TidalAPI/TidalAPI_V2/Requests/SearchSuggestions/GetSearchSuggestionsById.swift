
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.SearchSuggestions {

	/**
	 Get single searchSuggestion.

	 Retrieves single searchSuggestion by id.

	 **GET** /searchSuggestions/{id}
	 */
	func getById(id: String, countryCode: CountryCode? = nil, explicitFilter: String? = nil, include: [String]? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.SearchSuggestionsSingleDataDocument {
		try await client
			.path("/searchSuggestions/\(id)")
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
