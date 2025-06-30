import Foundation
import SwiftAPIClient

public extension TDO {

	struct UserCollectionAlbumsRelationshipRemoveOperationPayload: Codable, Equatable, Sendable {

		public var data: [UserCollectionAlbumsRelationshipRemoveOperationPayloadData]

		public enum CodingKeys: String, CodingKey {

			case data
		}

		public init(
			data: [UserCollectionAlbumsRelationshipRemoveOperationPayloadData]
		) {
			self.data = data
		}
	}
}
