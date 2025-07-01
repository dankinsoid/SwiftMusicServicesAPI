
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.Videos {

	/**
	 Get thumbnailArt relationship ("to-many").

	 Retrieves thumbnailArt relationship.

	 **GET** /videos/{id}/relationships/thumbnailArt
	 */
	func getByIdRelationshipsThumbnailArt(id: String, countryCode: String? = nil, include: Bool = false, pageCursor: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.MultiDataRelationshipDoc {
		try await client
			.path("/videos/\(id)/relationships/thumbnailArt")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"include": include ? ["thumbnailArt"] : nil,
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
