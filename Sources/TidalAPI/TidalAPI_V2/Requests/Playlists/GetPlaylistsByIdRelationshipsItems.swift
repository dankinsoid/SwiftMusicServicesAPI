
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.Playlists {

	/**
	 Get items relationship ("to-many").

	 Retrieves items relationship.

	 **GET** /playlists/{id}/relationships/items
	 */
	func getByIdRelationshipsItems(id: String, countryCode: String? = nil, pageCursor: String? = nil, include: Bool = false, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.MultiDataRelationshipDoc {
		try await client
			.path("/playlists/\(id)/relationships/items")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"page[cursor]": pageCursor,
				"include": include ? ["items"] : nil,
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
