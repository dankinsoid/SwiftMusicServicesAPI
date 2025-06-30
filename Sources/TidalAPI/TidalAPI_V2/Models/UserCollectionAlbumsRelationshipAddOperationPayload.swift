import Foundation
import SwiftAPIClient

public extension TDO {

	struct UserCollectionAlbumsRelationshipAddOperationPayload: Codable, Equatable, Sendable {

		public var data: [UserCollectionAlbumsRelationshipAddOperationPayloadData]

		public enum CodingKeys: String, CodingKey {

			case data
		}

		public init(
			data: [UserCollectionAlbumsRelationshipAddOperationPayloadData]
		) {
			self.data = data
		}
	}
}
