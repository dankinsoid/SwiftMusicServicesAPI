
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.UserRecommendations {

	/**
	 Get myMixes relationship ("to-many").

	 Retrieves myMixes relationship.

	 **GET** /userRecommendations/{id}/relationships/myMixes
	 */
	func getByIdRelationshipsMyMixes(id: String, countryCode: CountryCode? = nil, locale: String, include: Bool = true, pageCursor: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.MultiDataRelationshipDoc {
		try await client
			.path("/userRecommendations/\(id)/relationships/myMixes")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"locale": locale,
				"include": include ? ["myMixes"] : nil,
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
