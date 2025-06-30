import Foundation
import SwiftAPIClient

public extension TDO {

	struct ArtworksResource: Codable, Equatable, Sendable {

		/** resource unique identifier */
		public var id: String
		/** resource unique type */
		public var type: String
		public var attributes: ArtworksAttributes?
		public var relationships: ArtworksRelationships?

		public enum CodingKeys: String, CodingKey {

			case id
			case type
			case attributes
			case relationships
		}

		public init(
			id: String,
			type: String = "artworks",
			attributes: ArtworksAttributes? = nil,
			relationships: ArtworksRelationships? = nil
		) {
			self.id = id
			self.type = type
			self.attributes = attributes
			self.relationships = relationships
		}
	}
}
