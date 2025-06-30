
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.UserReports {

	/**
	 Get single userReport.

	 Retrieves single userReport by id.

	 **GET** /userReports/{id}
	 */
	func getById(id: String, include: [String]? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.UserReportsSingleDataDocument {
		try await client
			.path("/userReports/\(id)")
			.method(.get)
			.query([
				"include": include,
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
