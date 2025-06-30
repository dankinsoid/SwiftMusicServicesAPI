
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.UserCollections {

	/**
	 Add to playlists relationship ("to-many").

	 Adds item(s) to playlists relationship.

	 **POST** /userCollections/{id}/relationships/playlists
	 */
	func postByIdRelationshipsPlaylists(id: String, body: TDO.UserCollectionPlaylistsRelationshipRemoveOperationPayload, fileID: String = #fileID, line: UInt = #line) async throws {
		try await client
			.path("/userCollections/\(id)/relationships/playlists")
			.method(.post)
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
