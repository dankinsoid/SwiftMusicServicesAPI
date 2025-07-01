
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.UserRecommendations {

	/**
	 Get newArrivalMixes relationship ("to-many").

	 Retrieves newArrivalMixes relationship.

	 **GET** /userRecommendations/{id}/relationships/newArrivalMixes
	 */
	func getByIdRelationshipsNewArrivalMixes(id: String, countryCode: String? = nil, locale: String, include: Bool = false, pageCursor: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.MultiDataRelationshipDoc {
		try await client
			.path("/userRecommendations/\(id)/relationships/newArrivalMixes")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"locale": locale,
				"include": include ? ["newArrivalMixes"] : nil,
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
