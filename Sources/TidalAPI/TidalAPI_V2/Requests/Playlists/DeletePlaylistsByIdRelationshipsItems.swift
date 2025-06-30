
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension TidalAPI_V2.Playlists {

	/**
	 Delete from items relationship ("to-many").

	 Deletes item(s) from items relationship.

	 **DELETE** /playlists/{id}/relationships/items
	 */
	func deleteByIdRelationshipsItems(id: String, body: TDO.PlaylistItemsRelationshipRemoveOperationPayload, fileID: String = #fileID, line: UInt = #line) async throws {
		try await client
			.path("/playlists/\(id)/relationships/items")
			.method(.delete)
			.auth(enabled: true)
			.call(
				.http,
				as: .void,
				fileID: fileID,
				line: line
			)
	}
}
