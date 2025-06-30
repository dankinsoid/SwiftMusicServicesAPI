
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension TidalAPI_V2.Albums {

	/**
	 Get multiple albums.

	 Retrieves multiple albums by available filters, or without if applicable.

	 **GET** /albums
	 */
	func get(countryCode: String, include: [String]? = nil, filterbarcodeId: [String]? = nil, filterid: [String]? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.AlbumsMultiDataDocument {
		try await client
			.path("/albums")
			.method(.get)
			.query([
				"countryCode": countryCode,
				"include": include,
				"filter[barcodeId]": filterbarcodeId,
				"filter[id]": filterid,
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
