
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.UserCollections {

	/**
	 Delete from playlists relationship ("to-many").

	 Deletes item(s) from playlists relationship.

	 **DELETE** /userCollections/{id}/relationships/playlists
	 */
	func deleteByIdRelationshipsPlaylists(id: String, body: TDO.UserCollectionPlaylistsRelationshipRemoveOperationPayload, fileID: String = #fileID, line: UInt = #line) async throws {
		try await client
			.path("/userCollections/\(id)/relationships/playlists")
			.method(.delete)
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
