
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.Albums {

	/**
	 Get items relationship ("to-many").

	 Retrieves items relationship.

	 **GET** /albums/{id}/relationships/items
	 */
	func getByIdRelationshipsItems(id: String, countryCode: String? = nil, include: Bool = false, pageCursor: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.AlbumsItemsResourceIdentifier {
		try await client
			.path("/albums/\(id)/relationships/items")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"include": include ? ["items"] : nil,
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
