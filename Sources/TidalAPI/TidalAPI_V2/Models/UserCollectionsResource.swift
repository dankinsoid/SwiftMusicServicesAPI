import Foundation
import SwiftAPIClient

public extension TDO {

	struct UserCollectionsResource: Codable, Equatable, Sendable {

		/** resource unique identifier */
		public var id: String
		/** resource unique type */
		public var type: String
		public var attributes: UserCollectionsAttributes?
		public var relationships: UserCollectionsRelationships?

		public enum CodingKeys: String, CodingKey {

			case id
			case type
			case attributes
			case relationships
		}

		public init(
			id: String,
			type: String = "userCollections",
			attributes: UserCollectionsAttributes? = nil,
			relationships: UserCollectionsRelationships? = nil
		) {
			self.id = id
			self.type = type
			self.attributes = attributes
			self.relationships = relationships
		}
	}
}
