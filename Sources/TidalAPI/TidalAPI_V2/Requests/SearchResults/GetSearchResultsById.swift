
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.SearchResults {

	/**
	 Get single searchResult.

	 Retrieves single searchResult by id.

	 **GET** /searchResults/{id}
	 */
	func getById(id: String, countryCode: String? = nil, explicitFilter: String? = nil, include: [TDO.SearchInclude]? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.SearchResultsSingleDataDocument {
		try await client
			.path("/searchResults/\(id)")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"explicitFilter": explicitFilter,
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

public extension TDO {
	
	enum SearchInclude: String, Codable, CaseIterable, Sendable, Equatable {

		case albums
		case artists
		case playlists
		case tracks
		case videos
		case topHits
	}
}
