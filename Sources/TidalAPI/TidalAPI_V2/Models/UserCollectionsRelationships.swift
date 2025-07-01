import Foundation
import SwiftAPIClient

public extension TDO {

	struct UserCollectionsRelationships: Codable, Equatable, Sendable {

		public var albums: MultiDataRelationshipDoc
		public var artists: MultiDataRelationshipDoc
		public var playlists: MultiDataRelationshipDoc

		public enum CodingKeys: String, CodingKey {

			case albums
			case artists
			case playlists
		}

		public init(
			albums: MultiDataRelationshipDoc,
			artists: MultiDataRelationshipDoc,
			playlists: MultiDataRelationshipDoc
		) {
			self.albums = albums
			self.artists = artists
			self.playlists = playlists
		}
	}
}
