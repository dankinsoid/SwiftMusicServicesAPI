
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.Artists {

	/**
	 Get profileArt relationship ("to-many").

	 Retrieves profileArt relationship.

	 **GET** /artists/{id}/relationships/profileArt
	 */
	func getByIdRelationshipsProfileArt(id: String, countryCode: String? = nil, include: Bool = true, pageCursor: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.MultiDataRelationshipDoc {
		try await client
			.path("/artists/\(id)/relationships/profileArt")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"include": include ? ["profileArt"] : nil,
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
