
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.UserCollections {

	/**
	 Add to artists relationship ("to-many").

	 Adds item(s) to artists relationship.

	 **POST** /userCollections/{id}/relationships/artists
	 */
	func postByIdRelationshipsArtists(id: String, countryCode: CountryCode? = nil, body: TDO.UserCollectionArtistsRelationshipAddOperationPayload, fileID: String = #fileID, line: UInt = #line) async throws {
		try await client
			.path("/userCollections/\(id)/relationships/artists")
			.method(.post)
			.body(body)
			.query([
				"countryCode": countryCode,
			])
			.auth(enabled: true)
			.call(
				.http,
				as: .void,
				fileID: fileID,
				line: line
			)
	}
}
