import Foundation
import SwiftAPIClient

public extension TDO {

	struct ArtistProfileArtRelationshipUpdateOperationPayload: Codable, Equatable, Sendable {

		public var data: [ArtistProfileArtRelationshipUpdateOperationPayloadData]

		public enum CodingKeys: String, CodingKey {

			case data
		}

		public init(
			data: [ArtistProfileArtRelationshipUpdateOperationPayloadData]
		) {
			self.data = data
		}
	}
}
