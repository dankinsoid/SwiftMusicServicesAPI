
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.Playlists {

	/**
	 Add to items relationship ("to-many").

	 Adds item(s) to items relationship.

	 **POST** /playlists/{id}/relationships/items
	 */
	func postByIdRelationshipsItems(id: String, body: TDO.PlaylistItemsRelationshipAddOperationPayload, countryCode: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws {
		try await client
			.path("/playlists/\(id)/relationships/items")
			.method(.post)
			.body(body)
			.query([
				"countryCode": countryCode,
			])
			.auth(enabled: true)
			.call(
				.http,
				as: .void,
				fileID: fileID,
				line: line
			)
	}
}
