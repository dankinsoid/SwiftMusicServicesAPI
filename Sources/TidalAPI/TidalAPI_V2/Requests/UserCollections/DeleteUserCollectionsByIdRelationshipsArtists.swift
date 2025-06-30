
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.UserCollections {

	/**
	 Delete from artists relationship ("to-many").

	 Deletes item(s) from artists relationship.

	 **DELETE** /userCollections/{id}/relationships/artists
	 */
	func deleteByIdRelationshipsArtists(id: String, body: TDO.UserCollectionArtistsRelationshipRemoveOperationPayload, fileID: String = #fileID, line: UInt = #line) async throws {
		try await client
			.path("/userCollections/\(id)/relationships/artists")
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
