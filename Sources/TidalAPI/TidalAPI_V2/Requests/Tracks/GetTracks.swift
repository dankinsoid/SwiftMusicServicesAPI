
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.Tracks {

	/**
	 Get multiple tracks.

	 Retrieves multiple tracks by available filters, or without if applicable.

	 **GET** /tracks
	 */
	func get(countryCode: String? = nil, include: [Include]? = nil, isrc: [String]? = nil, id: [String]? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.TracksMultiDataDocument {
		try await client
			.path("/tracks")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"include": include,
				"filter[isrc]": isrc,
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
		case albums, artists, providers, radio, similarTracks
	}
}
