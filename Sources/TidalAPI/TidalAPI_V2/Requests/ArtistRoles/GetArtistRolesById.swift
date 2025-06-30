
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension TidalAPI_V2.ArtistRoles {

	/**
	 Get single artistRole.

	 Retrieves single artistRole by id.

	 **GET** /artistRoles/{id}
	 */
	func getById(id: String, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.ArtistRolesSingleDataDocument {
		try await client
			.path("/artistRoles/\(id)")
			.method(.get)
			.auth(enabled: true)
			.call(
				.http,
				as: .decodable,
				fileID: fileID,
				line: line
			)
	}
}
