
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.Artists {

	/**
	 Get albums relationship ("to-many").

	 Retrieves albums relationship.

	 **GET** /artists/{id}/relationships/albums
	 */
	func getByIdRelationshipsAlbums(id: String, countryCode: CountryCode? = nil, pageCursor: String? = nil, include: Bool = true, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.MultiDataRelationshipDoc {
		try await client
			.path("/artists/\(id)/relationships/albums")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"page[cursor]": pageCursor,
				"include": include ? ["albums"] : nil,
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
