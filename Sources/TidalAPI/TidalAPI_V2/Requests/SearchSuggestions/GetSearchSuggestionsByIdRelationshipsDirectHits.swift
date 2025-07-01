
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.SearchSuggestions {

	/**
	 Get directHits relationship ("to-many").

	 Retrieves directHits relationship.

	 **GET** /searchSuggestions/{id}/relationships/directHits
	 */
	func getByIdRelationshipsDirectHits(id: String, countryCode: String? = nil, explicitFilter: String? = nil, include: Bool = true, pageCursor: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.MultiDataRelationshipDoc {
		try await client
			.path("/searchSuggestions/\(id)/relationships/directHits")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"explicitFilter": explicitFilter,
				"include": include ? ["directHits"] : nil,
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
