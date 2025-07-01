
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.UserCollections {

	/**
	 Get albums relationship ("to-many").

	 Retrieves albums relationship.

	 **GET** /userCollections/{id}/relationships/albums
	 */
	func getByIdRelationshipsAlbums(id: String, countryCode: String? = nil, locale: String, pageCursor: String? = nil, include: Bool = false, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.MultiDataRelationshipDoc {
		try await client
			.path("/userCollections/\(id)/relationships/albums")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"locale": locale,
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
