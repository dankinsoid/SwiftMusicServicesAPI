
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.Artists {

	/**
	 Get tracks relationship ("to-many").

	 Retrieves tracks relationship.

	 **GET** /artists/{id}/relationships/tracks
	 */
	func getByIdRelationshipsTracks(id: String, countryCode: String? = nil, collapseBy: String, pageCursor: String? = nil, include: Bool = true, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.MultiDataRelationshipDoc {
		try await client
			.path("/artists/\(id)/relationships/tracks")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"collapseBy": collapseBy,
				"page[cursor]": pageCursor,
				"include": include ? ["tracks"] : nil,
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
