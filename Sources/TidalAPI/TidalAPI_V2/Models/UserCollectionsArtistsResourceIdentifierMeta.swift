import Foundation
import SwiftAPIClient

public extension TDO {

	struct UserCollectionsArtistsResourceIdentifierMeta: Codable, Equatable, Sendable {

		public var addedAt: Date?
		public var itemId: String?

		public enum CodingKeys: String, CodingKey {

			case addedAt
			case itemId
		}

		public init(
			addedAt: Date? = nil,
			itemId: String? = nil
		) {
			self.addedAt = addedAt
			self.itemId = itemId
		}
	}
}
