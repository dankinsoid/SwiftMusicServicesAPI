import Foundation
import SwiftAPIClient

public extension TDO {

	struct ArtistsResource: Codable, Equatable, Sendable {

		/** resource unique identifier */
		public var id: String
		/** resource unique type */
		public var type: String
		public var attributes: ArtistsAttributes?
		public var relationships: ArtistsRelationships?

		public enum CodingKeys: String, CodingKey {

			case id
			case type
			case attributes
			case relationships
		}

		public init(
			id: String,
			type: String = "artists",
			attributes: ArtistsAttributes? = nil,
			relationships: ArtistsRelationships? = nil
		) {
			self.id = id
			self.type = type
			self.attributes = attributes
			self.relationships = relationships
		}
	}
}
