import Foundation
import SwiftAPIClient

public extension TDO {

	struct PlaylistsResource: Codable, Equatable, Sendable {

		/** resource unique identifier */
		public var id: String
		/** resource unique type */
		public var type: String
		public var attributes: PlaylistsAttributes?
		public var relationships: PlaylistsRelationships?

		public enum CodingKeys: String, CodingKey {

			case id
			case type
			case attributes
			case relationships
		}

		public init(
			id: String,
			type: String = "playlists",
			attributes: PlaylistsAttributes? = nil,
			relationships: PlaylistsRelationships? = nil
		) {
			self.id = id
			self.type = type
			self.attributes = attributes
			self.relationships = relationships
		}
	}
}
