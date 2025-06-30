import Foundation
import SwiftAPIClient

public extension TDO {

	struct AlbumsResource: Codable, Equatable, Sendable {

		/** resource unique identifier */
		public var id: String
		/** resource unique type */
		public var type: String
		public var attributes: AlbumsAttributes?
		public var relationships: AlbumsRelationships?

		public enum CodingKeys: String, CodingKey {

			case id
			case type
			case attributes
			case relationships
		}

		public init(
			id: String,
			type: String = "albums",
			attributes: AlbumsAttributes? = nil,
			relationships: AlbumsRelationships? = nil
		) {
			self.id = id
			self.type = type
			self.attributes = attributes
			self.relationships = relationships
		}
	}
}
