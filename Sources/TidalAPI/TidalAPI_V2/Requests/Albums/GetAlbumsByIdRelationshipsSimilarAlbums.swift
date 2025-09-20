
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.Albums {

	/**
	 Get similarAlbums relationship ("to-many").

	 Retrieves similarAlbums relationship.

	 **GET** /albums/{id}/relationships/similarAlbums
	 */
	func getByIdRelationshipsSimilar(id: String, countryCode: CountryCode? = nil, include: Bool = true, pageCursor: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.MultiDataRelationshipDoc {
		try await client
			.path("/albums/\(id)/relationships/similarAlbums")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"include": include ? ["similarAlbums"] : nil,
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
