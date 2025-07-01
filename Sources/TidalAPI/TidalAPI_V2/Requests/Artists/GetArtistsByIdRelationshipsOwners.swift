
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.Artists {

	/**
	 Get owners relationship ("to-many").

	 Retrieves owners relationship.

	 **GET** /artists/{id}/relationships/owners
	 */
	func getByIdRelationshipsOwners(id: String, include: Bool = false, pageCursor: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.MultiDataRelationshipDoc {
		try await client
			.path("/artists/\(id)/relationships/owners")
			.method(.get)
			.query([
				"include": include ? ["owners"] : nil,
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
