
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension TidalAPI_V2.Videos {

	/**
	 Get albums relationship ("to-many").

	 Retrieves albums relationship.

	 **GET** /videos/{id}/relationships/albums
	 */
	func getByIdRelationshipsAlbums(id: String, countryCode: String, include: [String]? = nil, pageCursor: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.VideosMultiDataRelationshipDocument {
		try await client
			.path("/videos/\(id)/relationships/albums")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"include": include,
				"page[cursor]": pageCursor,
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
