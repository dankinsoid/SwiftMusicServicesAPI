
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension TidalAPI_V2.Artworks {

	/**
	 Get multiple artworks.

	 Retrieves multiple artworks by available filters, or without if applicable.

	 **GET** /artworks
	 */
	func get(countryCode: String, include: [String]? = nil, filterid: [String]? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.ArtworksMultiDataDocument {
		try await client
			.path("/artworks")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"include": include,
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
