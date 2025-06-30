
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension TidalAPI_V2.Users {

	/**
	 Get current user's user(s).

	 Retrieves current user's user(s).

	 **GET** /users/me
	 */
	func getMe(fileID: String = #fileID, line: UInt = #line) async throws -> TDO.UsersSingleDataDocument {
		try await client
			.path("/users/me")
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
