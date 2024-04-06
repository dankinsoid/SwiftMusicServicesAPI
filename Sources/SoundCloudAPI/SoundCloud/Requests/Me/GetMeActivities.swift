
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Me {

	/**
	 Returns the authenticated user's activities.

	 **GET** /me/activities
	 */
	func getActivities(access: [Access]? = nil, limit: Int? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> Activities {
		try await client
			.path("/me/activities")
			.method(.get)
			.query([
				"access": access,
				"limit": limit,
			])
			.auth(enabled: true)
			.call(
				.http,
				as: .decodable,
				fileID: fileID,
				line: line
			)
	}

	enum GetMeActivities {}
}
