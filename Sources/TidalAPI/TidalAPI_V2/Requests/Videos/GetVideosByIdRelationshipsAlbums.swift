
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.Videos {

	/**
	 Get albums relationship ("to-many").

	 Retrieves albums relationship.

	 **GET** /videos/{id}/relationships/albums
	 */
	func getByIdRelationshipsAlbums(id: String, countryCode: CountryCode? = nil, include: Bool = true, pageCursor: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.MultiDataRelationshipDoc {
		try await client
			.path("/videos/\(id)/relationships/albums")
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
