
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.UserCollections {

	/**
	 Get artists relationship ("to-many").

	 Retrieves artists relationship.

	 **GET** /userCollections/{id}/relationships/artists
	 */
	func getByIdRelationshipsArtists(id: String, countryCode: CountryCode? = nil, locale: String, pageCursor: String? = nil, include: Bool = true, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.MultiDataRelationshipDoc {
		try await client
			.path("/userCollections/\(id)/relationships/artists")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"locale": locale,
				"page[cursor]": pageCursor,
				"include": include ? ["artists"] : nil,
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
