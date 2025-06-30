import Foundation
import SwiftAPIClient

public extension TDO {

	struct PlaylistItemsRelationshipAddOperationPayload: Codable, Equatable, Sendable {

		public var data: [PlaylistItemsRelationshipAddOperationPayloadData]
		public var meta: PlaylistItemsRelationshipAddOperationPayloadMeta?

		public enum CodingKeys: String, CodingKey {

			case data
			case meta
		}

		public init(
			data: [PlaylistItemsRelationshipAddOperationPayloadData],
			meta: PlaylistItemsRelationshipAddOperationPayloadMeta? = nil
		) {
			self.data = data
			self.meta = meta
		}
	}
}
