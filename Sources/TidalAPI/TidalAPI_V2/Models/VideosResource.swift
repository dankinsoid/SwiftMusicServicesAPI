import Foundation
import SwiftAPIClient

public extension TDO {

	struct VideosResource: Codable, Equatable, Sendable {

		/** resource unique identifier */
		public var id: String
		/** resource unique type */
		public var type: String
		public var attributes: VideosAttributes?
		public var relationships: VideosRelationships?

		public enum CodingKeys: String, CodingKey {

			case id
			case type
			case attributes
			case relationships
		}

		public init(
			id: String,
			type: String = "videos",
			attributes: VideosAttributes? = nil,
			relationships: VideosRelationships? = nil
		) {
			self.id = id
			self.type = type
			self.attributes = attributes
			self.relationships = relationships
		}
	}
}
