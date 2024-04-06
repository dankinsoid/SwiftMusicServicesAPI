
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Me {

	/**
	 Returns the authenticated user’s information.

	 **GET** /me
	 */
	func get(fileID: String = #fileID, line: UInt = #line) async throws -> Me {
		try await client
			.path("/me")
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
