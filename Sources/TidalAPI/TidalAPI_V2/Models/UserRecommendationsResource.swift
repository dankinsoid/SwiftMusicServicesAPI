import Foundation
import SwiftAPIClient

public extension TDO {

	struct UserRecommendationsResource: Codable, Equatable, Sendable {

		/** resource unique identifier */
		public var id: String
		/** resource unique type */
		public var type: String
		public var attributes: UserRecommendationsAttributes?
		public var relationships: UserRecommendationsRelationships?

		public enum CodingKeys: String, CodingKey {

			case id
			case type
			case attributes
			case relationships
		}

		public init(
			id: String,
			type: String = "userRecommendations",
			attributes: UserRecommendationsAttributes? = nil,
			relationships: UserRecommendationsRelationships? = nil
		) {
			self.id = id
			self.type = type
			self.attributes = attributes
			self.relationships = relationships
		}
	}
}
