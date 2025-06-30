import Foundation
import SwiftAPIClient

public extension TDO {

	struct TracksRelationships: Codable, Equatable, Sendable {

		public var albums: MultiDataRelationshipDoc
		public var artists: MultiDataRelationshipDoc
		public var owners: MultiDataRelationshipDoc
		public var providers: MultiDataRelationshipDoc
		public var radio: MultiDataRelationshipDoc
		public var similarTracks: MultiDataRelationshipDoc

		public enum CodingKeys: String, CodingKey {

			case albums
			case artists
			case owners
			case providers
			case radio
			case similarTracks
		}

		public init(
			albums: MultiDataRelationshipDoc,
			artists: MultiDataRelationshipDoc,
			owners: MultiDataRelationshipDoc,
			providers: MultiDataRelationshipDoc,
			radio: MultiDataRelationshipDoc,
			similarTracks: MultiDataRelationshipDoc
		) {
			self.albums = albums
			self.artists = artists
			self.owners = owners
			self.providers = providers
			self.radio = radio
			self.similarTracks = similarTracks
		}
	}
}
