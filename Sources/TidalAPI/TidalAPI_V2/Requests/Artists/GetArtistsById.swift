
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.Artists {

	/**
	 Get single artist.

	 Retrieves single artist by id.

	 **GET** /artists/{id}
	 */
	func getById(id: String, countryCode: CountryCode? = nil, include: [Include]? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.ArtistsSingleDataDocument {
		try await client
			.path("/artists/\(id)")
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
