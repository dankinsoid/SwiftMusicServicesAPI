import Foundation
import SwiftAPIClient

public extension TDO {

	struct PlaylistItemsRelationshipRemoveOperationPayload: Codable, Equatable, Sendable {

		public var data: [PlaylistItemsRelationshipRemoveOperationPayloadData]

		public enum CodingKeys: String, CodingKey {

			case data
		}

		public init(
			data: [PlaylistItemsRelationshipRemoveOperationPayloadData]
		) {
			self.data = data
		}
	}
}
