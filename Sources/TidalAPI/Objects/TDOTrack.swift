import Foundation
import SwiftAPIClient
import SwiftMusicServicesApi

public extension Tidal.Objects {

	struct Track: Codable, Equatable, Sendable, Identifiable {

		public var id: Int
		public var title: String
		public var duration: Double
		public var replayGain: Double?
		public var peak: Double?
		public var allowStreaming: Bool?
		public var streamReady: Bool?
		public var streamStartDate: Date?
		public var premiumStreamingOnly: Bool?
		public var trackNumber: Int?
		public var volumeNumber: Int?
		public var version: String?
		public var popularity: Int?
		public var copyright: String?
		public var url: URL?
		public var isrc: String?
		public var editable: Bool?
		public var explicit: Bool?
		public var audioQuality: String?
		public var audioModes: [String]?
		public var artist: Artist?
		public var artists: [Artist]?
		public var album: Album?
		public var mixes: Mixes?

		// Playlist item
		public var dateAdded: Date?
		public var index: Int?
		public var itemUuid: String?

		public init(
			id: Int,
			title: String,
			duration: Double,
			replayGain: Double? = nil,
			peak: Double? = nil,
			allowStreaming: Bool? = nil,
			streamReady: Bool? = nil,
			streamStartDate: Date? = nil,
			premiumStreamingOnly: Bool? = nil,
			trackNumber: Int? = nil,
			volumeNumber: Int? = nil,
			version: String? = nil,
			popularity: Int? = nil,
			copyright: String? = nil,
			url: URL? = nil,
			isrc: String? = nil,
			editable: Bool? = nil,
			explicit: Bool? = nil,
			audioQuality: String? = nil,
			audioModes: [String]? = nil,
			artist: Artist? = nil,
			artists: [Artist]? = nil,
			album: Album? = nil,
			mixes: Mixes? = nil,
			dateAdded: Date? = nil,
			index: Int? = nil,
			itemUuid: String? = nil
		) {
			self.id = id
			self.title = title
			self.duration = duration
			self.replayGain = replayGain
			self.peak = peak
			self.allowStreaming = allowStreaming
			self.streamReady = streamReady
			self.streamStartDate = streamStartDate
			self.premiumStreamingOnly = premiumStreamingOnly
			self.trackNumber = trackNumber
			self.volumeNumber = volumeNumber
			self.version = version
			self.popularity = popularity
			self.copyright = copyright
			self.url = url
			self.isrc = isrc
			self.editable = editable
			self.explicit = explicit
			self.audioQuality = audioQuality
			self.audioModes = audioModes
			self.artist = artist
			self.artists = artists
			self.album = album
			self.mixes = mixes
			self.dateAdded = dateAdded
			self.index = index
			self.itemUuid = itemUuid
		}
	}
	
	struct UserItem<Item: Codable & Equatable & Sendable>: Codable, Equatable, Sendable {

		public var type: PlaylistItemType?
		public var created: Date?
		public var item: Item

		public init(type: PlaylistItemType? = nil, created: Date? = nil, item: Item) {
			self.type = type
			self.created = created
			self.item = item
		}
	}


	struct Artist: Codable, Equatable, Sendable, Identifiable {

		public var id: Int
		public var name: String?
		public var type: ItemType?
		public var artistTypes: [ItemType]?
		public var url: URL?
		public var picture: String?
		public var popularity: Int?
		public var artistRoles: [Tidal.Objects.Role]?
		public var mixes: Tidal.Objects.Mixes?

		init(
			id: Int,
			name: String? = nil,
			type: ItemType? = nil,
			artistTypes: [ItemType]? = nil,
			url: URL? = nil,
			picture: String? = nil,
			popularity: Int? = nil,
			artistRoles: [Tidal.Objects.Role]? = nil,
			mixes: Mixes? = nil
		) {
			self.id = id
			self.name = name
			self.type = type
			self.artistTypes = artistTypes
			self.url = url
			self.picture = picture
			self.popularity = popularity
			self.artistRoles = artistRoles
			self.mixes = mixes
		}
	
		public func pictureURL(size: Int = 160) -> URL? {
			guard let picture else { return nil }
			let size = coverSize(size)
			return Tidal.API.imageUrl(picture, width: size, height: size)
		}

		private func coverSize(_ size: Int) -> Int {
			max(8, min(128, Int(pow(2, ceil(log2(Double(size) / 10)))))) * 10
		}
	}

	struct ItemType: Codable, Hashable, LosslessStringConvertible, Sendable {

		public var value: String
		public var description: String { value }

		public static let main = ItemType("MAIN")
		public static let featured = ItemType("FEATURED")
		public static let contributor = ItemType("CONTRIBUTOR")
		public static let artist = ItemType("ARTIST")
		public static let album = ItemType("ALBUM")

		public init(_ value: String) {
			self.value = value
		}

		public init(from decoder: any Decoder) throws {
			try self.init(String(from: decoder))
		}

		public func encode(to encoder: any Encoder) throws {
			try value.encode(to: encoder)
		}
	}
	
	struct Role: Codable, Equatable, Sendable {
		public var categoryId: Int
		public var category: String

		public init(categoryId: Int, category: String) {
			self.categoryId = categoryId
			self.category = category
		}
	}

	struct Album: Codable, Equatable, Sendable, Identifiable {

		public var id: Int
		public var title: String
		public var duration: Double?
		public var streamReady: Bool?
		public var payToStream: Bool?
		public var adSupportedStreamReady: Bool?
		public var djReady: Bool?
		public var stemReady: Bool?
		public var streamStartDate: Date?
		public var allowStreaming: Bool?
		public var premiumStreamingOnly: Bool?
		public var numberOfTracks: Int?
		public var numberOfVideos: Int?
		public var numberOfVolumes: Int?
		public var releaseDate: String?
		public var copyright: String?
		public var type: TDO.ItemType?
		public var url: URL?
		public var cover: String?
		public var vibrantColor: String?
		public var videoCover: String?
		public var explicit: Bool?
		public var upc: String?
		public var popularity: Int?
		public var audioQuality: TDO.AudioQuality?
		public var audioModes: [TDO.AudioMode]?
		public var mediaMetadata: TDO.MediaMetadata?
		public var upload: Bool?
		public var artist: Artist?
		public var artists: [Artist]?
		
		public init(
			id: Int,
			title: String,
			duration: Double? = nil,
			streamReady: Bool? = nil,
			payToStream: Bool? = nil,
			adSupportedStreamReady: Bool? = nil,
			djReady: Bool? = nil,
			stemReady: Bool? = nil,
			streamStartDate: Date? = nil,
			allowStreaming: Bool? = nil,
			premiumStreamingOnly: Bool? = nil,
			numberOfTracks: Int? = nil,
			numberOfVideos: Int? = nil,
			numberOfVolumes: Int? = nil,
			releaseDate: String? = nil,
			copyright: String? = nil,
			type: TDO.ItemType? = nil,
			url: URL? = nil,
			cover: String? = nil,
			vibrantColor: String? = nil,
			videoCover: String? = nil,
			explicit: Bool? = nil,
			upc: String? = nil,
			popularity: Int? = nil,
			audioQuality: TDO.AudioQuality? = nil,
			audioModes: [TDO.AudioMode]? = nil,
			mediaMetadata: TDO.MediaMetadata? = nil,
			upload: Bool? = nil,
			artist: Artist? = nil,
			artists: [Artist]? = nil
		) {
			self.id = id
			self.title = title
			self.duration = duration
			self.streamReady = streamReady
			self.payToStream = payToStream
			self.adSupportedStreamReady = adSupportedStreamReady
			self.djReady = djReady
			self.stemReady = stemReady
			self.streamStartDate = streamStartDate
			self.allowStreaming = allowStreaming
			self.premiumStreamingOnly = premiumStreamingOnly
			self.numberOfTracks = numberOfTracks
			self.numberOfVideos = numberOfVideos
			self.numberOfVolumes = numberOfVolumes
			self.releaseDate = releaseDate
			self.copyright = copyright
			self.type = type
			self.url = url
			self.cover = cover
			self.vibrantColor = vibrantColor
			self.videoCover = videoCover
			self.explicit = explicit
			self.upc = upc
			self.popularity = popularity
			self.audioQuality = audioQuality
			self.audioModes = audioModes
			self.mediaMetadata = mediaMetadata
			self.upload = upload
			self.artist = artist
			self.artists = artists
		}
		
		public func coverURL(size: Int = 160) -> URL? {
			guard let cover else { return nil }
			let size = coverSize(size)
			return Tidal.API.imageUrl(cover, width: size, height: size)
		}

		public func videoCoverURL(size: Int = 160) -> URL? {
			videoCover.flatMap {
				let size = coverSize(size)
				return Tidal.API.videoUrl($0, width: size, height: size)
			}
		}

		private func coverSize(_ size: Int) -> Int {
			max(8, min(128, Int(pow(2, ceil(log2(Double(size) / 10)))))) * 10
		}
	}

struct MediaMetadata: Codable, Equatable, Sendable {
	
	public var tags: Set<String>?
	
	public init(tags: Set<String>? = nil) {
		self.tags = tags
	}
}

	struct MixKind: Codable, Hashable, CodingKey, LosslessStringConvertible {

		public var value: String
		public var description: String { value }
		public var stringValue: String { value }
		public var intValue: Int? { Int(value) }

		public static let trackMix = MixKind("TRACK_MIX")
		public static let masterTrackMix = MixKind("MASTER_TRACK_MIX")
		public static let artistMix = MixKind("ARTIST_MIX")

		public init(_ value: String) {
			self.value = value
		}

		public init(stringValue: String) {
			self.init(stringValue)
		}

		public init(intValue: Int) {
			self.init("\(intValue)")
		}

		public init(from decoder: any Decoder) throws {
			try self.init(String(from: decoder))
		}

		public func encode(to encoder: any Encoder) throws {
			try value.encode(to: encoder)
		}
	}

	struct Mixes: ExpressibleByDictionaryLiteral, Codable, Equatable, CustomStringConvertible, Sendable {

		public var values: [MixKind: String]
		public var description: String { values.description }

		public init(_ values: [MixKind: String]) {
			self.values = values
		}

		public init(dictionaryLiteral elements: (MixKind, String)...) {
			values = Dictionary(uniqueKeysWithValues: elements)
		}

		public init(from decoder: any Decoder) throws {
			let container = try decoder.container(keyedBy: MixKind.self)
			values = [:]
			for key in container.allKeys {
				values[key] = try container.decode(String.self, forKey: key)
			}
		}

		public func encode(to encoder: any Encoder) throws {
			var container = encoder.container(keyedBy: MixKind.self)
			for (key, value) in values {
				try container.encode(value, forKey: key)
			}
		}
	}

	struct PlaylistItemType: Hashable, Codable, Sendable {

		public var value: String

		public static let track = PlaylistItemType("track")
		public static let video = PlaylistItemType("video")
		public static let artist = PlaylistItemType("artist")
		public static let album = PlaylistItemType("album")

		public init(_ value: String) {
			self.value = value
		}

		public init(from decoder: any Decoder) throws {
			try self.init(String(from: decoder))
		}

		public func encode(to encoder: any Encoder) throws {
			try value.encode(to: encoder)
		}
	}
}

extension Tidal.Objects.Track: Mockable {
	public static let mock = Tidal.Objects.Track(
		id: 123_456_789,
		title: "Mock Track",
		duration: 240.0,
		replayGain: -5.0,
		peak: 0.8,
		allowStreaming: true,
		streamReady: true,
		streamStartDate: Date(),
		premiumStreamingOnly: false,
		trackNumber: 1,
		volumeNumber: 1,
		version: nil,
		popularity: 75,
		copyright: "2023 Mock Records",
		url: URL(string: "https://example.com/track"),
		isrc: "US1234567890",
		editable: false,
		explicit: false,
		audioQuality: "HIGH",
		audioModes: ["STEREO"],
		artist: Tidal.Objects.Artist.mock,
		artists: [Tidal.Objects.Artist.mock],
		album: Tidal.Objects.Album.mock,
		mixes: nil,
		dateAdded: Date(),
		index: 0,
		itemUuid: "mock-uuid-123"
	)
}

extension Tidal.Objects.Artist: Mockable {
	public static let mock = Tidal.Objects.Artist(
		id: 123_456,
		name: "Mock Artist",
		type: .main
	)
}

extension Tidal.Objects.Album: Mockable {
	public static let mock = Tidal.Objects.Album(
		id: 123_456,
		title: "Mock Album",
		cover: "mock-cover-id",
		videoCover: nil
	)
}

extension Tidal.Objects.UserItem: Mockable where Item: Mockable {
	
	public static var mock: Self {
		Tidal.Objects.UserItem(
			type: .track,
			created: Date(),
			item: Item.mock
		)
	}
}

extension Tidal.Objects.ItemType: Mockable {
	public static let mock = Tidal.Objects.ItemType.main
}

extension Tidal.Objects.PlaylistItemType: Mockable {
	public static let mock = Tidal.Objects.PlaylistItemType.track
}
