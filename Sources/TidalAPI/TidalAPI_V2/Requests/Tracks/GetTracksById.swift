
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.Tracks {

	/**
	 Get single track.

	 Retrieves single track by id.

	 **GET** /tracks/{id}
	 */
	func getById(id: String, countryCode: String? = nil, include: [String]? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.TracksSingleDataDocument {
		try await client
			.path("/tracks/\(id)")
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
