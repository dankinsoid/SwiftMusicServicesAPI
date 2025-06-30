
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension TidalAPI_V2.Artworks {

	/**
	 Get single artwork.

	 Retrieves single artwork by id.

	 **GET** /artworks/{id}
	 */
	func getById(id: String, countryCode: String, include: [String]? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.ArtworksSingleDataDocument {
		try await client
			.path("/artworks/\(id)")
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
