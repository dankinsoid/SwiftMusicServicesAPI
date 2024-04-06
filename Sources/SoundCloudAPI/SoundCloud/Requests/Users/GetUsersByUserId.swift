
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Users {

	/**
	 Returns a user.

	 **GET** /users/{user_id}
	 */
	func getByUserId(userId user_id: Int, fileID: String = #fileID, line: UInt = #line) async throws -> User {
		try await client
			.path("/users/\(user_id)")
			.method(.get)
			.auth(enabled: true)
			.call(
				.http,
				as: .decodable,
				fileID: fileID,
				line: line
			)
	}
}
