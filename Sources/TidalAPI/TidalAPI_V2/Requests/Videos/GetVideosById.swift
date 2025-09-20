
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.Videos {

	/**
	 Get single video.

	 Retrieves single video by id.

	 **GET** /videos/{id}
	 */
	func getById(id: String, countryCode: CountryCode? = nil, include: [Include]? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.VideosSingleDataDocument {
		try await client
			.path("/videos/\(id)")
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
