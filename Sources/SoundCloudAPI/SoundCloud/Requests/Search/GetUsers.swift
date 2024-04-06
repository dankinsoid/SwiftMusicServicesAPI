
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Search {

	/**
	 Performs a user search based on a query

	 **GET** /users
	 */
	func getUsers(q: String? = nil, ids: String? = nil, limit: Int? = nil, offset: Int? = nil, linkedPartitioning: Bool? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> Users {
		try await client
			.path("/users")
			.method(.get)
			.query([
				"q": q,
				"ids": ids,
				"limit": limit,
				"offset": offset,
				"linked_partitioning": linkedPartitioning,
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
