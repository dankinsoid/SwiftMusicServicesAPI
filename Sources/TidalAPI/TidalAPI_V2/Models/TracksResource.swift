import Foundation
import SwiftAPIClient

public extension TDO {

	struct TracksResource: Codable, Equatable, Sendable {

		/** resource unique identifier */
		public var id: String
		/** resource unique type */
		public var type: String
		public var attributes: TracksAttributes?
		public var relationships: TracksRelationships?

		public enum CodingKeys: String, CodingKey {

			case id
			case type
			case attributes
			case relationships
		}

		public init(
			id: String,
			type: String = "tracks",
			attributes: TracksAttributes? = nil,
			relationships: TracksRelationships? = nil
		) {
			self.id = id
			self.type = type
			self.attributes = attributes
			self.relationships = relationships
		}
	}
}
