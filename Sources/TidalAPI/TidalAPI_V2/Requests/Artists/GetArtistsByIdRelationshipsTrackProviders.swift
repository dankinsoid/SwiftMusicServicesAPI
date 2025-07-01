
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.Artists {

	/**
	 Get trackProviders relationship ("to-many").

	 Retrieves trackProviders relationship.

	 **GET** /artists/{id}/relationships/trackProviders
	 */
	func getByIdRelationshipsTrackProviders(id: String, pageCursor: String? = nil, include: Bool = false, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.MultiDataRelationshipDoc {
		try await client
			.path("/artists/\(id)/relationships/trackProviders")
			.method(.get)
			.query([
				"page[cursor]": pageCursor,
				"include": include ? ["trackProviders"] : nil,
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
