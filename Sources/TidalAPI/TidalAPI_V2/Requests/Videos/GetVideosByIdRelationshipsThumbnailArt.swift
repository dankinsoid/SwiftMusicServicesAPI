
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension TidalAPI_V2.Videos {

	/**
	 Get thumbnailArt relationship ("to-many").

	 Retrieves thumbnailArt relationship.

	 **GET** /videos/{id}/relationships/thumbnailArt
	 */
	func getByIdRelationshipsThumbnailArt(id: String, countryCode: String, include: [String]? = nil, pageCursor: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.VideosMultiDataRelationshipDocument {
		try await client
			.path("/videos/\(id)/relationships/thumbnailArt")
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
