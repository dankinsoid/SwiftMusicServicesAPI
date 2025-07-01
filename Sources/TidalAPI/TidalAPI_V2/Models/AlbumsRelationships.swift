import Foundation
import SwiftAPIClient

public extension TDO {

	struct AlbumsRelationships: Codable, Equatable, Sendable {

		public var artists: MultiDataRelationshipDoc
		public var coverArt: MultiDataRelationshipDoc
		public var items: MultiDataRelationshipDoc
		public var providers: MultiDataRelationshipDoc
		public var similarAlbums: MultiDataRelationshipDoc

		public enum CodingKeys: String, CodingKey {

			case artists
			case coverArt
			case items
			case providers
			case similarAlbums
		}

		public init(
			artists: MultiDataRelationshipDoc,
			coverArt: MultiDataRelationshipDoc,
			items: MultiDataRelationshipDoc,
			providers: MultiDataRelationshipDoc,
			similarAlbums: MultiDataRelationshipDoc
		) {
			self.artists = artists
			self.coverArt = coverArt
			self.items = items
			self.providers = providers
			self.similarAlbums = similarAlbums
		}
	}
}
