
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.UserEntitlements {

	/**
	 Get single userEntitlement.

	 Retrieves single userEntitlement by id.

	 **GET** /userEntitlements/{id}
	 */
	func getById(id: String, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.UserEntitlementsSingleDataDocument {
		try await client
			.path("/userEntitlements/\(id)")
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
