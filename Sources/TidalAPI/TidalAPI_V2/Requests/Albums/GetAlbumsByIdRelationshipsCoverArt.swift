
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.Albums {

	/**
	 Get coverArt relationship ("to-many").

	 Retrieves coverArt relationship.

	 **GET** /albums/{id}/relationships/coverArt
	 */
	func getByIdRelationshipsCoverArt(id: String, countryCode: String? = nil, include: [String]? = nil, pageCursor: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.AlbumsMultiDataRelationshipDocument {
		try await client
			.path("/albums/\(id)/relationships/coverArt")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"include": include,
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
