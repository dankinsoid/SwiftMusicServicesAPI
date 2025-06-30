
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.UserCollections {

	/**
	 Delete from albums relationship ("to-many").

	 Deletes item(s) from albums relationship.

	 **DELETE** /userCollections/{id}/relationships/albums
	 */
	func deleteByIdRelationshipsAlbums(id: String, body: TDO.UserCollectionAlbumsRelationshipRemoveOperationPayload, fileID: String = #fileID, line: UInt = #line) async throws {
		try await client
			.path("/userCollections/\(id)/relationships/albums")
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
