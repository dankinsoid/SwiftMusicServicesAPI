
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.Videos {

	/**
	 Get providers relationship ("to-many").

	 Retrieves providers relationship.

	 **GET** /videos/{id}/relationships/providers
	 */
	func getByIdRelationshipsProviders(id: String, countryCode: String? = nil, include: [String]? = nil, pageCursor: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.VideosMultiDataRelationshipDocument {
		try await client
			.path("/videos/\(id)/relationships/providers")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"include": include,
				"page[cursor]": pageCursor,
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
