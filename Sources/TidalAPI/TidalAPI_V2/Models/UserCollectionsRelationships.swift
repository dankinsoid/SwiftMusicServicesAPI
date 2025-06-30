import Foundation
import SwiftAPIClient

public extension TDO {

	struct UserCollectionsRelationships: Codable, Equatable, Sendable {

		public var albums: UserCollectionsAlbumsMultiDataRelationshipDocument
		public var artists: UserCollectionsArtistsMultiDataRelationshipDocument
		public var playlists: UserCollectionsPlaylistsMultiDataRelationshipDocument

		public enum CodingKeys: String, CodingKey {

			case albums
			case artists
			case playlists
		}

		public init(
			albums: UserCollectionsAlbumsMultiDataRelationshipDocument,
			artists: UserCollectionsArtistsMultiDataRelationshipDocument,
			playlists: UserCollectionsPlaylistsMultiDataRelationshipDocument
		) {
			self.albums = albums
			self.artists = artists
			self.playlists = playlists
		}
	}
}
