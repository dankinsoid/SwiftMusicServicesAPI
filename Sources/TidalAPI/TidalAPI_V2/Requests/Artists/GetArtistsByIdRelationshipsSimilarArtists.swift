
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.Artists {

	/**
	 Get similarArtists relationship ("to-many").

	 Retrieves similarArtists relationship.

	 **GET** /artists/{id}/relationships/similarArtists
	 */
	func getByIdRelationshipsSimilar(id: String, countryCode: String? = nil, pageCursor: String? = nil, include: Bool = false, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.MultiDataRelationshipDoc {
		try await client
			.path("/artists/\(id)/relationships/similarArtists")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"page[cursor]": pageCursor,
				"include": include ? ["similarArtists"] : nil,
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
