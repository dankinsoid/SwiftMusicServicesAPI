import Foundation
import SwiftAPIClient

public extension TDO {

	struct SearchResultsRelationships: Codable, Equatable, Sendable {

		public var albums: MultiDataRelationshipDoc
		public var artists: MultiDataRelationshipDoc
		public var playlists: MultiDataRelationshipDoc
		public var topHits: MultiDataRelationshipDoc
		public var tracks: MultiDataRelationshipDoc
		public var videos: MultiDataRelationshipDoc

		public enum CodingKeys: String, CodingKey {

			case albums
			case artists
			case playlists
			case topHits
			case tracks
			case videos
		}

		public init(
			albums: MultiDataRelationshipDoc,
			artists: MultiDataRelationshipDoc,
			playlists: MultiDataRelationshipDoc,
			topHits: MultiDataRelationshipDoc,
			tracks: MultiDataRelationshipDoc,
			videos: MultiDataRelationshipDoc
		) {
			self.albums = albums
			self.artists = artists
			self.playlists = playlists
			self.topHits = topHits
			self.tracks = tracks
			self.videos = videos
		}
	}
}
