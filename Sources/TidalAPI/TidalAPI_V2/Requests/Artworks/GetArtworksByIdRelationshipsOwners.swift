
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.Artworks {

	/**
	 Get owners relationship ("to-many").

	 Retrieves owners relationship.

	 **GET** /artworks/{id}/relationships/owners
	 */
	func getByIdRelationshipsOwners(id: String, include: Bool = true, pageCursor: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.MultiDataRelationshipDoc {
		try await client
			.path("/artworks/\(id)/relationships/owners")
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
