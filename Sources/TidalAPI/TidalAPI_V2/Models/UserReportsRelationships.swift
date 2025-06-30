import Foundation
import SwiftAPIClient

public extension TDO {

	struct UserReportsRelationships: Codable, Equatable, Sendable {

		public var owners: MultiDataRelationshipDoc
		public var reportedResources: MultiDataRelationshipDoc

		public enum CodingKeys: String, CodingKey {

			case owners
			case reportedResources
		}

		public init(
			owners: MultiDataRelationshipDoc,
			reportedResources: MultiDataRelationshipDoc
		) {
			self.owners = owners
			self.reportedResources = reportedResources
		}
	}
}
