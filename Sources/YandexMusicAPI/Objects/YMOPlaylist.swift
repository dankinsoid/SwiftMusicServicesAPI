import Foundation
import VDCodable

public extension Yandex.Music.Objects {

	struct Playlist<T: Codable>: Codable {

		public let playlistUuid: String
		public let uid: Int
		public let kind: Int
		public let trackCount: Int?
		public let title: String
		public let owner: Owner?
		public let cover: Cover?
		public let tags: [Tag]?
		public let regions: [String]?
		public let snapshot: Int?
		public let ogImage: String?
		public let revision: Int?
		public let durationMs: Int?
		public let collective: Bool?
		public let available: Bool?
		public let modified: Date?
		public let created: Date?
		public let visibility: RawEnum<Visibility>?
		public let isBanner: Bool?
		public let prerolls: [Preroll]?
		public let isPremiere: Bool?
		public var tracks: [T]?

		public init(
			playlistUuid: String,
			uid: Int,
			kind: Int,
			trackCount: Int? = nil,
			title: String,
			owner: Yandex.Music.Objects.Owner? = nil,
			cover: Yandex.Music.Objects.Cover? = nil,
			tags: [Yandex.Music.Objects.Tag]? = nil,
			regions: [String]? = nil,
			snapshot: Int? = nil,
			ogImage: String? = nil,
			revision: Int? = nil,
			durationMs: Int? = nil,
			collective: Bool? = nil,
			available: Bool? = nil,
			modified: Date? = nil,
			created: Date? = nil,
			visibility: RawEnum<Yandex.Music.Objects.Visibility>? = nil,
			isBanner: Bool? = nil,
			prerolls: [Yandex.Music.Objects.Preroll]? = nil,
			isPremiere: Bool? = nil,
			tracks: [T]? = nil
		) {
			self.playlistUuid = playlistUuid
			self.uid = uid
			self.kind = kind
			self.trackCount = trackCount
			self.title = title
			self.owner = owner
			self.cover = cover
			self.tags = tags
			self.regions = regions
			self.snapshot = snapshot
			self.ogImage = ogImage
			self.revision = revision
			self.durationMs = durationMs
			self.collective = collective
			self.available = available
			self.modified = modified
			self.created = created
			self.visibility = visibility
			self.isBanner = isBanner
			self.prerolls = prerolls
			self.isPremiere = isPremiere
			self.tracks = tracks
		}
	}

	struct Preroll: Codable {

		public init() {}
	}

	struct TrackShort: Codable, Hashable {

		public let timestamp: Date?
		public let id: Int
		public let albumId: Int?

		public init(timestamp: Date? = nil, id: Int, albumId: Int? = nil) {
			self.timestamp = timestamp
			self.id = id
			self.albumId = albumId
		}

		public func hash(into hasher: inout Hasher) {
			id.hash(into: &hasher)
		}

		public static func == (_ lhs: TrackShort, _ rhs: TrackShort) -> Bool {
			lhs.id == rhs.id
		}
	}
}

public extension YMO.Playlist {

	func copy<R: Codable>(tracks: [R]) -> YMO.Playlist<R> {
		YMO.Playlist<R>(
			uid: uid,
			kind: kind,
			trackCount: trackCount,
			title: title,
			owner: owner,
			cover: cover,
			tags: tags,
			regions: regions,
			snapshot: snapshot,
			ogImage: ogImage,
			revision: revision,
			durationMs: durationMs,
			collective: collective,
			available: available,
			modified: modified,
			created: created,
			visibility: visibility,
			isBanner: isBanner,
			prerolls: prerolls,
			isPremiere: isPremiere,
			tracks: tracks
		)
	}
}
