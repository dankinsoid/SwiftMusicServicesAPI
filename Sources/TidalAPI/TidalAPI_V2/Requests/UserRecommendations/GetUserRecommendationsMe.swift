
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.UserRecommendations {

	/**
	     Get current user's userRecommendation(s).

	     This operation is deprecated and will be removed shortly. Please switch to the equivalent /userRecommendations/{userId} endpoint. You can find your user id by calling /users/me.
	 Retrieves current user's userRecommendation(s).

	     **GET** /userRecommendations/me
	     */
	func getMe(countryCode: String? = nil, locale: String, include: [String]? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.UserRecommendationsSingleDataDocument {
		try await client
			.path("/userRecommendations/me")
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
}
