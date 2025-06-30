
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.Providers {

	/**
	 Get single provider.

	 Retrieves single provider by id.

	 **GET** /providers/{id}
	 */
	func getById(id: String, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.ProvidersSingleDataDocument {
		try await client
			.path("/providers/\(id)")
			.method(.get)
			.auth(enabled: true)
			.call(
				.http,
				as: .decodable,
				fileID: fileID,
				line: line
			)
	}
}
