
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.Artists {

	/**
	 Get multiple artists.

	 Retrieves multiple artists by available filters, or without if applicable.

	 **GET** /artists
	 */
	func get(countryCode: String? = nil, include: [Include]? = nil, handle: [String]? = nil, id: [String]? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.ArtistsMultiDataDocument {
		try await client
			.path("/artists")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"include": include,
				"filter[handle]": handle,
				"filter[id]": id,
			])
			.auth(enabled: true)
			.call(
				.http,
				as: .decodable,
				fileID: fileID,
				line: line
			)
	}

	enum Include: String, CaseIterable, Codable, Sendable, Equatable {
		case albums, radio, roles, similarArtists, trackProviders, tracks, videos
	}
}
