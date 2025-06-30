import Foundation
import SwiftAPIClient

public extension TDO {

	struct AlbumsItemsMultiDataRelationshipDocument: Codable, Equatable, Sendable {

		public var data: [AlbumsItemsResourceIdentifier]?
		public var links: Links?

		public enum CodingKeys: String, CodingKey {

			case data
			case links
		}

		public init(
			data: [AlbumsItemsResourceIdentifier]? = nil,
			links: Links? = nil
		) {
			self.data = data
			self.links = links
		}
	}
}
