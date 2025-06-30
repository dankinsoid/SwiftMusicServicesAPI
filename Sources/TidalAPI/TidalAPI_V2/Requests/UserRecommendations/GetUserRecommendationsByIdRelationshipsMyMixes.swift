
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension TidalAPI_V2.UserRecommendations {

	/**
	 Get myMixes relationship ("to-many").

	 Retrieves myMixes relationship.

	 **GET** /userRecommendations/{id}/relationships/myMixes
	 */
	func getByIdRelationshipsMyMixes(id: String, countryCode: String, locale: String, include: [String]? = nil, pageCursor: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.UserRecommendationsMultiDataRelationshipDocument {
		try await client
			.path("/userRecommendations/\(id)/relationships/myMixes")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"locale": locale,
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
