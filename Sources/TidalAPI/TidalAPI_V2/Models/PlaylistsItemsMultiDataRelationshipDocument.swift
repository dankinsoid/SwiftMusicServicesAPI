import Foundation
import SwiftAPIClient

public extension TDO {

	struct PlaylistsItemsMultiDataRelationshipDocument: Codable, Equatable, Sendable {

		public var data: [PlaylistsItemsResourceIdentifier]?
		public var links: Links?

		public enum CodingKeys: String, CodingKey {

			case data
			case links
		}

		public init(
			data: [PlaylistsItemsResourceIdentifier]? = nil,
			links: Links? = nil
		) {
			self.data = data
			self.links = links
		}
	}
}
