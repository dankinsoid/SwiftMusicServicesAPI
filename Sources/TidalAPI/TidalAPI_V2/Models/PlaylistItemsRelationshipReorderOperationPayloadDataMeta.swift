import Foundation
import SwiftAPIClient

public extension TDO {

	struct PlaylistItemsRelationshipReorderOperationPayloadDataMeta: Codable, Equatable, Sendable {

		public var itemId: String

		public enum CodingKeys: String, CodingKey {

			case itemId
		}

		public init(
			itemId: String
		) {
			self.itemId = itemId
		}
	}
}
