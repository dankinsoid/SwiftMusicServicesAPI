
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.Tracks {

	/**
	 Get albums relationship ("to-many").

	 Retrieves albums relationship.

	 **GET** /tracks/{id}/relationships/albums
	 */
	func getByIdRelationshipsAlbums(id: String, countryCode: String? = nil, include: Bool = false, pageCursor: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.MultiDataRelationshipDoc {
		try await client
			.path("/tracks/\(id)/relationships/albums")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"include": include ? ["albums"] : nil,
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
