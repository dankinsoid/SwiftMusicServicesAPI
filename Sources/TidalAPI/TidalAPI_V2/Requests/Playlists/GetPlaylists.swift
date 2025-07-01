
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.Playlists {

	/**
	 Get multiple playlists.

	 Retrieves multiple playlists by available filters, or without if applicable.

	 **GET** /playlists
	 */
	func get(countryCode: String? = nil, pageCursor: String? = nil, include: [Include]? = nil, ownersId: [String]? = nil, id: [String]? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.PlaylistsMultiDataDocument {
		try await client
			.path("/playlists")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"page[cursor]": pageCursor,
				"include": include,
				"filter[r.owners.id]": ownersId,
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
		case items, owners
	}
}
