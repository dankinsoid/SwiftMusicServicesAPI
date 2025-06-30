import Foundation
import SwiftAPIClient

public extension TDO {

	struct PlaylistCoverArtRelationshipUpdateOperationPayload: Codable, Equatable, Sendable {

		public var data: [PlaylistCoverArtRelationshipUpdateOperationPayloadData]

		public enum CodingKeys: String, CodingKey {

			case data
		}

		public init(
			data: [PlaylistCoverArtRelationshipUpdateOperationPayloadData]
		) {
			self.data = data
		}
	}
}
