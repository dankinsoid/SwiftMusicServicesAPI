
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.Playlists {

	/**
	 Get coverArt relationship ("to-many").

	 Retrieves coverArt relationship.

	 **GET** /playlists/{id}/relationships/coverArt
	 */
	func getByIdRelationshipsCoverArt(id: String, countryCode: String? = nil, include: Bool = false, pageCursor: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.MultiDataRelationshipDoc {
		try await client
			.path("/playlists/\(id)/relationships/coverArt")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"include": include ? ["coverArt"] : nil,
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
