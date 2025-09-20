
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.SearchResults {

	/**
	 Get albums relationship ("to-many").

	 Retrieves albums relationship.

	 **GET** /searchResults/{id}/relationships/albums
	 */
	func getByIdRelationshipsAlbums(id: String, countryCode: CountryCode? = nil, explicitFilter: String? = nil, include: Bool = true, pageCursor: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.MultiDataRelationshipDoc {
		try await client
			.path("/searchResults/\(id)/relationships/albums")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"explicitFilter": explicitFilter,
				"include": include ? ["albums"] : nil,
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
