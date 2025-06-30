import Foundation
import SwiftAPIClient

public extension TDO {

	struct UserReportsCreateOperationPayloadDataRelationshipsReportedResources: Codable, Equatable, Sendable {

		public var data: [ReportedResource]

		public enum CodingKeys: String, CodingKey {

			case data
		}

		public init(
			data: [ReportedResource]
		) {
			self.data = data
		}
	}
}
