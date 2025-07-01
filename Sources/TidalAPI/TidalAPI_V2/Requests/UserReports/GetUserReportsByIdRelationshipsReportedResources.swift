
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.UserReports {

	/**
	 Get reportedResources relationship ("to-many").

	 Retrieves reportedResources relationship.

	 **GET** /userReports/{id}/relationships/reportedResources
	 */
	func getByIdRelationshipsReportedResources(id: String, include: Bool = false, pageCursor: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.MultiDataRelationshipDoc {
		try await client
			.path("/userReports/\(id)/relationships/reportedResources")
			.method(.get)
			.query([
				"include": include ? ["reportedResources"] : nil,
				"page[cursor]": pageCursor,
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
