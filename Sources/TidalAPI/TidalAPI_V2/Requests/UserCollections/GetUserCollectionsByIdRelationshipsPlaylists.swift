
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.UserCollections {

	/**
	 Get playlists relationship ("to-many").

	 Retrieves playlists relationship.

	 **GET** /userCollections/{id}/relationships/playlists
	 */
	func getByIdRelationshipsPlaylists(id: String, countryCode: CountryCode? = nil, pageCursor: String? = nil, include: Bool = true, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.MultiDataRelationshipDoc {
		try await client
			.path("/userCollections/\(id)/relationships/playlists")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"page[cursor]": pageCursor,
				"include": include ? ["playlists"] : nil,
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
