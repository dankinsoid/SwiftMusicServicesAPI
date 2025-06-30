import Foundation
import SwiftAPIClient

public extension TDO {

	struct PlaylistsRelationships: Codable, Equatable, Sendable {

		public var coverArt: MultiDataRelationshipDoc
		public var items: PlaylistsItemsMultiDataRelationshipDocument
		public var owners: MultiDataRelationshipDoc

		public enum CodingKeys: String, CodingKey {

			case coverArt
			case items
			case owners
		}

		public init(
			coverArt: MultiDataRelationshipDoc,
			items: PlaylistsItemsMultiDataRelationshipDocument,
			owners: MultiDataRelationshipDoc
		) {
			self.coverArt = coverArt
			self.items = items
			self.owners = owners
		}
	}
}
