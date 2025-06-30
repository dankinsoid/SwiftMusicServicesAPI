import Foundation
import SwiftAPIClient

public extension TDO {

	struct PlaylistItemsRelationshipReorderOperationPayloadMeta: Codable, Equatable, Sendable {

		public var positionBefore: String

		public enum CodingKeys: String, CodingKey {

			case positionBefore
		}

		public init(
			positionBefore: String
		) {
			self.positionBefore = positionBefore
		}
	}
}
