
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension TidalAPI_V2.ArtistRoles {

	/**
	 Get multiple artistRoles.

	 Retrieves multiple artistRoles by available filters, or without if applicable.

	 **GET** /artistRoles
	 */
	func get(filterid: [String]? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.ArtistRolesMultiDataDocument {
		try await client
			.path("/artistRoles")
			.method(.get)
			.query([
				"filter[id]": filterid,
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
