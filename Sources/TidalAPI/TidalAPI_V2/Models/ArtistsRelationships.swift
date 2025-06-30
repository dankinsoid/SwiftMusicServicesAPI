import Foundation
import SwiftAPIClient

public extension TDO {

	struct ArtistsRelationships: Codable, Equatable, Sendable {

		public var albums: MultiDataRelationshipDoc
		public var owners: MultiDataRelationshipDoc
		public var profileArt: MultiDataRelationshipDoc
		public var radio: MultiDataRelationshipDoc
		public var roles: MultiDataRelationshipDoc
		public var similarArtists: MultiDataRelationshipDoc
		public var trackProviders: ArtistsTrackProvidersMultiDataRelationshipDocument
		public var tracks: MultiDataRelationshipDoc
		public var videos: MultiDataRelationshipDoc

		public enum CodingKeys: String, CodingKey {

			case albums
			case owners
			case profileArt
			case radio
			case roles
			case similarArtists
			case trackProviders
			case tracks
			case videos
		}

		public init(
			albums: MultiDataRelationshipDoc,
			owners: MultiDataRelationshipDoc,
			profileArt: MultiDataRelationshipDoc,
			radio: MultiDataRelationshipDoc,
			roles: MultiDataRelationshipDoc,
			similarArtists: MultiDataRelationshipDoc,
			trackProviders: ArtistsTrackProvidersMultiDataRelationshipDocument,
			tracks: MultiDataRelationshipDoc,
			videos: MultiDataRelationshipDoc
		) {
			self.albums = albums
			self.owners = owners
			self.profileArt = profileArt
			self.radio = radio
			self.roles = roles
			self.similarArtists = similarArtists
			self.trackProviders = trackProviders
			self.tracks = tracks
			self.videos = videos
		}
	}
}
