
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.Tracks {

	/**
	 Get similarTracks relationship ("to-many").

	 Retrieves similarTracks relationship.

	 **GET** /tracks/{id}/relationships/similarTracks
	 */
	func getByIdRelationshipsSimilar(id: String, countryCode: String? = nil, pageCursor: String? = nil, include: Bool = false, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.MultiDataRelationshipDoc {
		try await client
			.path("/tracks/\(id)/relationships/similarTracks")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"page[cursor]": pageCursor,
				"include": include ? ["similarTracks"] : nil,
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
