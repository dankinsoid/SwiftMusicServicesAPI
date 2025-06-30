import Foundation
import SwiftAPIClient

public extension TDO {

	struct UserReportsCreateOperationPayloadDataRelationships: Codable, Equatable, Sendable {

		public var reportedResources: UserReportsCreateOperationPayloadDataRelationshipsReportedResources

		public enum CodingKeys: String, CodingKey {

			case reportedResources
		}

		public init(
			reportedResources: UserReportsCreateOperationPayloadDataRelationshipsReportedResources
		) {
			self.reportedResources = reportedResources
		}
	}
}
