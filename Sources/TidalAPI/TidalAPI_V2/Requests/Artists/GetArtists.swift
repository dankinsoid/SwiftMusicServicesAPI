
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.Artists {

	/**
	 Get multiple artists.

	 Retrieves multiple artists by available filters, or without if applicable.

	 **GET** /artists
	 */
	func get(countryCode: String? = nil, include: [String]? = nil, filterhandle: [String]? = nil, filterid: [String]? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.ArtistsMultiDataDocument {
		try await client
			.path("/artists")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"include": include,
				"filter[handle]": filterhandle,
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
