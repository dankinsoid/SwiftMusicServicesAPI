
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.Albums {

	/**
	 Get single album.

	 Retrieves single album by id.

	 **GET** /albums/{id}
	 */
	func getById(id: String, countryCode: String? = nil, include: [Include]? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.AlbumsSingleDataDocument {
		try await client
			.path("/albums/\(id)")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"include": include,
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
