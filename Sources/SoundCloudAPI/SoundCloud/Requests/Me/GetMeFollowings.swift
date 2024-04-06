
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Me {

	/**
	 Returns a list of users who are followed by the authenticated user.

	 **GET** /me/followings
	 */
	func getFollowings(limit: Int? = nil, offset: Int? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> Users {
		try await client
			.path("/me/followings")
			.method(.get)
			.query([
				"limit": limit,
				"offset": offset,
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
