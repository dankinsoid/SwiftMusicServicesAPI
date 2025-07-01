
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.Albums {

	/**
	 Get providers relationship ("to-many").

	 Retrieves providers relationship.

	 **GET** /albums/{id}/relationships/providers
	 */
	func getByIdRelationshipsProviders(id: String, countryCode: String? = nil, include: Bool = false, pageCursor: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.MultiDataRelationshipDoc {
		try await client
			.path("/albums/\(id)/relationships/providers")
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
