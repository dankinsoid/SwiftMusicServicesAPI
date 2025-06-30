
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension TidalAPI_V2.TrackFiles {

	/**
	 Get single trackFile.

	 Retrieves single trackFile by id.

	 **GET** /trackFiles/{id}
	 */
	func getById(id: String, formats: String, usage: String, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.TrackFilesSingleDataDocument {
		try await client
			.path("/trackFiles/\(id)")
			.method(.get)
			.query([
				"formats": formats,
				"usage": usage,
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
