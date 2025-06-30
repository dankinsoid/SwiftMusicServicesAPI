import Foundation
import SwiftAPIClient

public extension TDO {

	struct UserCollectionArtistsRelationshipAddOperationPayload: Codable, Equatable, Sendable {

		public var data: [UserCollectionArtistsRelationshipAddOperationPayloadData]

		public enum CodingKeys: String, CodingKey {

			case data
		}

		public init(
			data: [UserCollectionArtistsRelationshipAddOperationPayloadData]
		) {
			self.data = data
		}
	}
}
