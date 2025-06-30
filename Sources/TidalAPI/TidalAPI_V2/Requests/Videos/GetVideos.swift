
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension TidalAPI_V2.Videos {

	/**
	 Get multiple videos.

	 Retrieves multiple videos by available filters, or without if applicable.

	 **GET** /videos
	 */
	func get(countryCode: String, include: [String]? = nil, filterisrc: [String]? = nil, filterid: [String]? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.VideosMultiDataDocument {
		try await client
			.path("/videos")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"include": include,
				"filter[isrc]": filterisrc,
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
