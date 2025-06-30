
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension TidalAPI_V2.UserRecommendations {

	/**
	 Get discoveryMixes relationship ("to-many").

	 Retrieves discoveryMixes relationship.

	 **GET** /userRecommendations/{id}/relationships/discoveryMixes
	 */
	func getByIdRelationshipsDiscoveryMixes(id: String, countryCode: String, locale: String, include: [String]? = nil, pageCursor: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.UserRecommendationsMultiDataRelationshipDocument {
		try await client
			.path("/userRecommendations/\(id)/relationships/discoveryMixes")
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
