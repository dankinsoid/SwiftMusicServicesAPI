import Foundation
import SwiftAPIClient

public extension TDO {

	struct UserCollectionArtistsRelationshipRemoveOperationPayload: Codable, Equatable, Sendable {

		public var data: [UserCollectionArtistsRelationshipRemoveOperationPayloadData]

		public enum CodingKeys: String, CodingKey {

			case data
		}

		public init(
			data: [UserCollectionArtistsRelationshipRemoveOperationPayloadData]
		) {
			self.data = data
		}
	}
}
