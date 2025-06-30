import Foundation
import SwiftAPIClient

public extension TDO {

	struct UserCollectionPlaylistsRelationshipRemoveOperationPayload: Codable, Equatable, Sendable {

		public var data: [UserCollectionPlaylistsRelationshipRemoveOperationPayloadData]

		public enum CodingKeys: String, CodingKey {

			case data
		}

		public init(
			data: [UserCollectionPlaylistsRelationshipRemoveOperationPayloadData]
		) {
			self.data = data
		}
	}
}
