
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.Albums {

	/**
	 Get artists relationship ("to-many").

	 Retrieves artists relationship.

	 **GET** /albums/{id}/relationships/artists
	 */
	func getByIdRelationshipsArtists(id: String, countryCode: String? = nil, include: Bool = true, pageCursor: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.MultiDataRelationshipDoc {
		try await client
			.path("/albums/\(id)/relationships/artists")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"include": include ? ["artists"] : nil,
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
