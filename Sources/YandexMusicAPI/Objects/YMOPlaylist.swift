import Foundation
import VDCodable
import SwiftMusicServicesApi

public extension Yandex.Music.Objects {

	struct Playlist<T: Codable>: Codable {

		public let playlistUuid: String
		public let uid: Int
		public let kind: Int
		public let trackCount: Int?
		public let title: String?
		public let owner: Owner?
		public let cover: Cover?
		public let tags: [Tag]
		public let regions: [String]
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
		public let prerolls: [Preroll]
		public let isPremiere: Bool?
		public var tracks: [T]

		public init(
			playlistUuid: String,
			uid: Int,
			kind: Int,
			trackCount: Int? = nil,
			title: String?,
			owner: Yandex.Music.Objects.Owner? = nil,
			cover: Yandex.Music.Objects.Cover? = nil,
			tags: [Yandex.Music.Objects.Tag] = [],
			regions: [String] = [],
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
			prerolls: [Yandex.Music.Objects.Preroll] = [],
			isPremiere: Bool? = nil,
			tracks: [T] = []
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
        
        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: Yandex.Music.Objects.Playlist<T>.CodingKeys.self)
            self.playlistUuid = try container.decode(String.self, forKey: .playlistUuid)
            self.uid = try container.decode(Int.self, forKey: .uid)
            self.kind = try container.decode(Int.self, forKey: .kind)
            self.trackCount = try? container.decodeIfPresent(Int.self, forKey: .trackCount)
            self.title = try? container.decodeIfPresent(String.self, forKey: .title)
            self.owner = try? container.decodeIfPresent(Yandex.Music.Objects.Owner.self, forKey: .owner)
            self.cover = try? container.decodeIfPresent(Yandex.Music.Objects.Cover.self, forKey: .cover)
            self.tags = try container.decodeIfPresent(SafeDecodeArray<Yandex.Music.Objects.Tag>.self, forKey: .tags)?.array ?? []
            self.regions = try container.decodeIfPresent(SafeDecodeArray<String>.self, forKey: .regions)?.array ?? []
            self.snapshot = try? container.decodeIfPresent(Int.self, forKey: .snapshot)
            self.ogImage = try? container.decodeIfPresent(String.self, forKey: .ogImage)
            self.revision = try? container.decodeIfPresent(Int.self, forKey: .revision)
            self.durationMs = try? container.decodeIfPresent(Int.self, forKey: .durationMs)
            self.collective = try? container.decodeIfPresent(Bool.self, forKey: .collective)
            self.available = try? container.decodeIfPresent(Bool.self, forKey: .available)
            self.modified = try? container.decodeIfPresent(Date.self, forKey: .modified)
            self.created = try? container.decodeIfPresent(Date.self, forKey: .created)
            self.visibility = try? container.decodeIfPresent(RawEnum<Yandex.Music.Objects.Visibility>.self, forKey: .visibility)
            self.isBanner = try? container.decodeIfPresent(Bool.self, forKey: .isBanner)
            self.prerolls = try container.decodeIfPresent(SafeDecodeArray<Yandex.Music.Objects.Preroll>.self, forKey: .prerolls)?.array ?? []
            self.isPremiere = try? container.decodeIfPresent(Bool.self, forKey: .isPremiere)
            self.tracks = try container.decodeIfPresent(SafeDecodeArray<T>.self, forKey: .tracks)?.array ?? []
        }
	}

	struct Preroll: Codable {

		public init() {}
	}

	struct TrackShort: Codable, Hashable {

		public let timestamp: Date?
		public let id: String
		public let albumId: Int?

		public init(timestamp: Date? = nil, id: String, albumId: Int? = nil) {
			self.timestamp = timestamp
			self.id = id
			self.albumId = albumId
		}

        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: Yandex.Music.Objects.TrackShort.CodingKeys.self)
            self.timestamp = try? container.decodeIfPresent(Date.self, forKey: .timestamp)
            do {
                self.id = try container.decode(String.self, forKey: .id)
            } catch {
                self.id = try "\(container.decode(Int.self, forKey: .id))"
            }
            self.albumId = try? container.decodeIfPresent(Int.self, forKey: .albumId)
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
			playlistUuid: playlistUuid,
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
