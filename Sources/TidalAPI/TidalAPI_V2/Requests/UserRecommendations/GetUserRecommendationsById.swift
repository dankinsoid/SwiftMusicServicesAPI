
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.UserRecommendations {

	/**
	 Get single userRecommendation.

	 Retrieves single userRecommendation by id.

	 **GET** /userRecommendations/{id}
	 */
	func getById(id: String, countryCode: CountryCode? = nil, locale: String, include: [Include]? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.UserRecommendationsSingleDataDocument {
		try await client
			.path("/userRecommendations/\(id)")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"locale": locale,
				"include": include,
			])
			.auth(enabled: true)
			.call(
				.http,
				as: .decodable,
				fileID: fileID,
				line: line
			)
	}

	enum Include: String, CaseIterable, Codable, Sendable, Equatable {
		case discoveryMixes, myMixes, newArrivalMixes
	}
}
