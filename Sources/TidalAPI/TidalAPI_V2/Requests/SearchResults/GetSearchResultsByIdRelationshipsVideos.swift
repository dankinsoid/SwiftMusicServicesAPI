
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.SearchResults {

	/**
	 Get videos relationship ("to-many").

	 Retrieves videos relationship.

	 **GET** /searchResults/{id}/relationships/videos
	 */
	func getByIdRelationshipsVideos(id: String, countryCode: String? = nil, explicitFilter: String? = nil, include: Bool = false, pageCursor: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.MultiDataRelationshipDoc {
		try await client
			.path("/searchResults/\(id)/relationships/videos")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"explicitFilter": explicitFilter,
				"include": include ? ["videos"] : nil,
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
