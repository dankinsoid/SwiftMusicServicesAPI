
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.UserRecommendations {

	/**
	 Get newArrivalMixes relationship ("to-many").

	 Retrieves newArrivalMixes relationship.

	 **GET** /userRecommendations/{id}/relationships/newArrivalMixes
	 */
	func getByIdRelationshipsNewArrivalMixes(id: String, countryCode: String? = nil, locale: String, include: [String]? = nil, pageCursor: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.UserRecommendationsMultiDataRelationshipDocument {
		try await client
			.path("/userRecommendations/\(id)/relationships/newArrivalMixes")
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
