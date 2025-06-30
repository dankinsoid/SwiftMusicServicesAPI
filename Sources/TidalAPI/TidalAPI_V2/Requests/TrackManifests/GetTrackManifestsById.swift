
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension TidalAPI_V2.TrackManifests {

	/**
	 Get single trackManifest.

	 Retrieves single trackManifest by id.

	 **GET** /trackManifests/{id}
	 */
	func getById(id: String, manifestType: String, formats: String, uriScheme: String, usage: String, adaptive: String, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.TrackManifestsSingleDataDocument {
		try await client
			.path("/trackManifests/\(id)")
			.method(.get)
			.query([
				"manifestType": manifestType,
				"formats": formats,
				"uriScheme": uriScheme,
				"usage": usage,
				"adaptive": adaptive,
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
