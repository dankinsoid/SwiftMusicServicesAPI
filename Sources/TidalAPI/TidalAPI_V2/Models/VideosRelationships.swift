import Foundation
import SwiftAPIClient

public extension TDO {

	struct VideosRelationships: Codable, Equatable, Sendable {

		public var albums: MultiDataRelationshipDoc
		public var artists: MultiDataRelationshipDoc
		public var providers: MultiDataRelationshipDoc
		public var thumbnailArt: MultiDataRelationshipDoc

		public enum CodingKeys: String, CodingKey {

			case albums
			case artists
			case providers
			case thumbnailArt
		}

		public init(
			albums: MultiDataRelationshipDoc,
			artists: MultiDataRelationshipDoc,
			providers: MultiDataRelationshipDoc,
			thumbnailArt: MultiDataRelationshipDoc
		) {
			self.albums = albums
			self.artists = artists
			self.providers = providers
			self.thumbnailArt = thumbnailArt
		}
	}
}
