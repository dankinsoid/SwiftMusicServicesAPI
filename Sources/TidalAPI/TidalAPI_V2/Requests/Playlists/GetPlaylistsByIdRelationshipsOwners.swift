
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.Playlists {

	/**
	 Get owners relationship ("to-many").

	 Retrieves owners relationship.

	 **GET** /playlists/{id}/relationships/owners
	 */
	func getByIdRelationshipsOwners(id: String, countryCode: String? = nil, include: [String]? = nil, pageCursor: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.PlaylistsMultiDataRelationshipDocument {
		try await client
			.path("/playlists/\(id)/relationships/owners")
			.method(.get)
			.query([
				"countryCode": countryCode,
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
