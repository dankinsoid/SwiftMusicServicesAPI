import Foundation
import SwiftAPIClient
import SwiftMusicServicesApi
import VDCodable

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
		public let regions: Set<CountryCode>
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
			regions: Set<CountryCode> = [],
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
			playlistUuid = try container.decode(String.self, forKey: .playlistUuid)
			uid = try container.decode(Int.self, forKey: .uid)
			kind = try container.decode(Int.self, forKey: .kind)
			trackCount = try? container.decodeIfPresent(Int.self, forKey: .trackCount)
			title = try? container.decodeIfPresent(String.self, forKey: .title)
			owner = try? container.decodeIfPresent(Yandex.Music.Objects.Owner.self, forKey: .owner)
			cover = try? container.decodeIfPresent(Yandex.Music.Objects.Cover.self, forKey: .cover)
			tags = try container.decodeIfPresent(SafeDecodeArray<Yandex.Music.Objects.Tag>.self, forKey: .tags)?.array ?? []
			regions = try container.decodeIfPresent(SafeDecodeArray<CountryCode>.self, forKey: .regions).map { Set($0.array) } ?? []
			snapshot = try? container.decodeIfPresent(Int.self, forKey: .snapshot)
			ogImage = try? container.decodeIfPresent(String.self, forKey: .ogImage)
			revision = try? container.decodeIfPresent(Int.self, forKey: .revision)
			durationMs = try? container.decodeIfPresent(Int.self, forKey: .durationMs)
			collective = try? container.decodeIfPresent(Bool.self, forKey: .collective)
			available = try? container.decodeIfPresent(Bool.self, forKey: .available)
			modified = try? container.decodeIfPresent(Date.self, forKey: .modified)
			created = try? container.decodeIfPresent(Date.self, forKey: .created)
			visibility = try? container.decodeIfPresent(RawEnum<Yandex.Music.Objects.Visibility>.self, forKey: .visibility)
			isBanner = try? container.decodeIfPresent(Bool.self, forKey: .isBanner)
			prerolls = try container.decodeIfPresent(SafeDecodeArray<Yandex.Music.Objects.Preroll>.self, forKey: .prerolls)?.array ?? []
			isPremiere = try? container.decodeIfPresent(Bool.self, forKey: .isPremiere)
			tracks = try container.decodeIfPresent(SafeDecodeArray<T>.self, forKey: .tracks)?.array ?? []
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
			timestamp = try? container.decodeIfPresent(Date.self, forKey: .timestamp)
			do {
				id = try container.decode(String.self, forKey: .id)
			} catch {
				id = try "\(container.decode(Int.self, forKey: .id))"
			}
			albumId = try? container.decodeIfPresent(Int.self, forKey: .albumId)
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

extension Yandex.Music.Objects.Playlist: Mockable where T: Mockable {
	public static var mock: Yandex.Music.Objects.Playlist<T> {
		Yandex.Music.Objects.Playlist(
			playlistUuid: "mock-playlist-uuid",
			uid: 123_456_789,
			kind: 3,
			trackCount: 10,
			title: "Mock Playlist",
			owner: Yandex.Music.Objects.Owner.mock,
			cover: Yandex.Music.Objects.Cover.mock,
			tags: [Yandex.Music.Objects.Tag.mock],
			regions: [.RU],
			snapshot: 1000,
			ogImage: "https://avatars.yandex.net/get-music-content/mock/og_image",
			revision: 500,
			durationMs: 1_800_000,
			collective: false,
			available: true,
			modified: Date(),
			created: Date(),
			visibility: RawEnum<Yandex.Music.Objects.Visibility>(.public),
			isBanner: false,
			prerolls: [Yandex.Music.Objects.Preroll.mock],
			isPremiere: false,
			tracks: [T.mock]
		)
	}
}

extension Yandex.Music.Objects.TrackShort: Mockable {
	public static let mock = Yandex.Music.Objects.TrackShort(
		timestamp: Date(),
		id: "mock_track_short_id",
		albumId: 654_321
	)
}

extension Yandex.Music.Objects.Preroll: Mockable {
	public static let mock = Yandex.Music.Objects.Preroll()
}
