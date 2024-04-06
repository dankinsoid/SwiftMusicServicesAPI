
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Users {

	/**
	 Returns list of user's links added to their profile (website, facebook, instagram).

	 **GET** /users/{user_id}/web-profiles
	 */
	func getByUserIdWebProfiles(userId user_id: Int, limit: Int? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> WebProfiles {
		try await client
			.path("/users/\(user_id)/web-profiles")
			.method(.get)
			.query([
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
}
