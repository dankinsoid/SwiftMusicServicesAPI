
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.UserReports {

	/**
	 Create single userReport.

	 Creates a new userReport.

	 **POST** /userReports
	 */
	func post(body: TDO.UserReportCreateOperationPayload, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.UserReportsSingleDataDocument {
		try await client
			.path("/userReports")
			.method(.post)
			.body(body)
			.auth(enabled: true)
			.call(
				.http,
				as: .decodable,
				fileID: fileID,
				line: line
			)
	}
}
