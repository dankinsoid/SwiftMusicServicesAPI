
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension TidalAPI_V2.Providers {

	/**
	 Get multiple providers.

	 Retrieves multiple providers by available filters, or without if applicable.

	 **GET** /providers
	 */
	func get(filterid: [String]? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.ProvidersMultiDataDocument {
		try await client
			.path("/providers")
			.method(.get)
			.query([
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
