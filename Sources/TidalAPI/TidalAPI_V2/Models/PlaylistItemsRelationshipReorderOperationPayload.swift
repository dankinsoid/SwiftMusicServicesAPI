import Foundation
import SwiftAPIClient

public extension TDO {

	struct PlaylistItemsRelationshipReorderOperationPayload: Codable, Equatable, Sendable {

		public var data: [PlaylistItemsRelationshipReorderOperationPayloadData]
		public var meta: PlaylistItemsRelationshipReorderOperationPayloadMeta?

		public enum CodingKeys: String, CodingKey {

			case data
			case meta
		}

		public init(
			data: [PlaylistItemsRelationshipReorderOperationPayloadData],
			meta: PlaylistItemsRelationshipReorderOperationPayloadMeta? = nil
		) {
			self.data = data
			self.meta = meta
		}
	}
}
