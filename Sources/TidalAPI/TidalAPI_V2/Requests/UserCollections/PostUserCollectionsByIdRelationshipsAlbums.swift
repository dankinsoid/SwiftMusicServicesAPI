
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.UserCollections {

	/**
	 Add to albums relationship ("to-many").

	 Adds item(s) to albums relationship.

	 **POST** /userCollections/{id}/relationships/albums
	 */
	func postByIdRelationshipsAlbums(id: String, countryCode: CountryCode? = nil, body: TDO.UserCollectionAlbumsRelationshipAddOperationPayload, fileID: String = #fileID, line: UInt = #line) async throws {
		try await client
			.path("/userCollections/\(id)/relationships/albums")
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
