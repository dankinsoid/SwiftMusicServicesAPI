import Foundation
import SwiftAPIClient

public extension TDO {

	struct UserReportsResource: Codable, Equatable, Sendable {

		/** resource unique identifier */
		public var id: String
		/** resource unique type */
		public var type: String
		public var attributes: UserReportsAttributes?
		public var relationships: UserReportsRelationships?

		public enum CodingKeys: String, CodingKey {

			case id
			case type
			case attributes
			case relationships
		}

		public init(
			id: String,
			type: String = "userReports",
			attributes: UserReportsAttributes? = nil,
			relationships: UserReportsRelationships? = nil
		) {
			self.id = id
			self.type = type
			self.attributes = attributes
			self.relationships = relationships
		}
	}
}
