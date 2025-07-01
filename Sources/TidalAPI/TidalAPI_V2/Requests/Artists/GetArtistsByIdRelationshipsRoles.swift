
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.Artists {

	/**
	 Get roles relationship ("to-many").

	 Retrieves roles relationship.

	 **GET** /artists/{id}/relationships/roles
	 */
	func getByIdRelationshipsRoles(id: String, include: Bool = false, pageCursor: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.MultiDataRelationshipDoc {
		try await client
			.path("/artists/\(id)/relationships/roles")
			.method(.get)
			.query([
				"include": include ? ["roles"] : nil,
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
