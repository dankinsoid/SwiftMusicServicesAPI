import Foundation
import VDCodable

public extension Yandex.Music.Objects {
	struct Playlist<T: Codable>: Codable {
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
	}

	struct Preroll: Codable {}

	struct TrackShort: Codable, Hashable {
		public let timestamp: Date?
		public let id: Int
		public let albumId: Int?

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
		YMO.Playlist<R>(uid: uid, kind: kind, trackCount: trackCount, title: title, owner: owner, cover: cover, tags: tags, regions: regions, snapshot: snapshot, ogImage: ogImage, revision: revision, durationMs: durationMs, collective: collective, available: available, modified: modified, created: created, visibility: visibility, isBanner: isBanner, prerolls: prerolls, isPremiere: isPremiere, tracks: tracks)
	}
}
