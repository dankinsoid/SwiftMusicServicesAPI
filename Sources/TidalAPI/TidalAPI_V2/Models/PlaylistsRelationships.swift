import Foundation
import SwiftAPIClient

public extension TDO {

	struct PlaylistsRelationships: Codable, Equatable, Sendable {

		public var coverArt: MultiDataRelationshipDoc
		public var items: MultiDataRelationshipDoc
		public var owners: MultiDataRelationshipDoc

		public enum CodingKeys: String, CodingKey {

			case coverArt
			case items
			case owners
		}

		public init(
			coverArt: MultiDataRelationshipDoc,
			items: MultiDataRelationshipDoc,
			owners: MultiDataRelationshipDoc
		) {
			self.coverArt = coverArt
			self.items = items
			self.owners = owners
		}
	}
}
