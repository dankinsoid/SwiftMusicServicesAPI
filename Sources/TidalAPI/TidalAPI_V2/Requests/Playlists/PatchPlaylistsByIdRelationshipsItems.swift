
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.Playlists {

	/**
	 Update items relationship ("to-many").

	 Updates items relationship.

	 **PATCH** /playlists/{id}/relationships/items
	 */
	func patchByIdRelationshipsItems(id: String, body: TDO.PlaylistItemsRelationshipReorderOperationPayload, fileID: String = #fileID, line: UInt = #line) async throws {
		try await client
			.path("/playlists/\(id)/relationships/items")
			.method(.patch)
			.body(body)
			.auth(enabled: true)
			.call(
				.http,
				as: .void,
				fileID: fileID,
				line: line
			)
	}
}
