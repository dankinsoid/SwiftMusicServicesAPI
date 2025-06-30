
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.Playlists {

	/**
	 Update coverArt relationship ("to-many").

	 Updates coverArt relationship.

	 **PATCH** /playlists/{id}/relationships/coverArt
	 */
	func patchByIdRelationshipsCoverArt(id: String, body: TDO.PlaylistCoverArtRelationshipUpdateOperationPayload, fileID: String = #fileID, line: UInt = #line) async throws {
		try await client
			.path("/playlists/\(id)/relationships/coverArt")
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
