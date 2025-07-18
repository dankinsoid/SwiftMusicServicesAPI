
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.Tracks {

	/**
	 Get providers relationship ("to-many").

	 Retrieves providers relationship.

	 **GET** /tracks/{id}/relationships/providers
	 */
	func getByIdRelationshipsProviders(id: String, countryCode: String? = nil, include: Bool = true, pageCursor: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.MultiDataRelationshipDoc {
		try await client
			.path("/tracks/\(id)/relationships/providers")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"include": include ? ["providers"] : nil,
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
