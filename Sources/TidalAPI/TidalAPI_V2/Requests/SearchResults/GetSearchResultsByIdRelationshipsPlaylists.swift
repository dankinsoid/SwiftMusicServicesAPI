
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.SearchResults {

	/**
	 Get playlists relationship ("to-many").

	 Retrieves playlists relationship.

	 **GET** /searchResults/{id}/relationships/playlists
	 */
	func getByIdRelationshipsPlaylists(id: String, countryCode: CountryCode? = nil, explicitFilter: String? = nil, include: Bool = true, pageCursor: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.MultiDataRelationshipDoc {
		try await client
			.path("/searchResults/\(id)/relationships/playlists")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"explicitFilter": explicitFilter,
				"include": include ? ["playlists"] : nil,
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
