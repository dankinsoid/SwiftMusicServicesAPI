
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.UserCollections {

	/**
	 Get single userCollection.

	 Retrieves single userCollection by id.

	 **GET** /userCollections/{id}
	 */
	func getById(id: String, locale: String, countryCode: String? = nil, include: [String]? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.UserCollectionsSingleDataDocument {
		try await client
			.path("/userCollections/\(id)")
			.method(.get)
			.query([
				"locale": locale,
				"countryCode": countryCode,
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
