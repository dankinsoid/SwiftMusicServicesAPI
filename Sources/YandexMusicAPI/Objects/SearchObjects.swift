import Foundation
import SwiftMusicServicesApi
import VDCodable

public extension Yandex.Music.Objects {
	enum SearchType: String, Codable, CaseIterable {
		case all, track, playlist, album, artist, unknown // (трек, плейлист, альбом, исполнитель)

		public init(from decoder: Decoder) throws {
			self = try Self(rawValue: String(from: decoder)) ?? .unknown
		}
	}

	// MARK: - Best

	struct BestResult: Codable {
		public let type: SearchType?
		public let result: Best
	}

	struct Best: Codable {

		public let id: Int
		public var available: Bool?
		public var availableAsRbt: Bool?
		public var availableForPremiumUsers: Bool?
		public var lyricsAvailable: Bool?

		public var storageDir: String?
		public var durationMs: Int?
		public var explicit: Bool?
		public var title: String?

		public var regions: Set<CountryCode>
		public var tracks: [Track]
		public var artists: [Artist]
		public var albums: [Album]
		public var playlists: [Playlist<TrackShort>]
		public var videos: [Video]

		public init(id: Int, available: Bool? = nil, availableAsRbt: Bool? = nil, availableForPremiumUsers: Bool? = nil, lyricsAvailable: Bool? = nil, storageDir: String? = nil, durationMs: Int? = nil, explicit: Bool? = nil, title: String? = nil, regions: Set<CountryCode> = [], tracks: [Track] = [], artists: [Artist] = [], albums: [Album] = [], playlists: [Playlist<TrackShort>] = [], videos: [Video] = []) {
			self.id = id
			self.available = available
			self.availableAsRbt = availableAsRbt
			self.availableForPremiumUsers = availableForPremiumUsers
			self.lyricsAvailable = lyricsAvailable
			self.storageDir = storageDir
			self.durationMs = durationMs
			self.explicit = explicit
			self.title = title
			self.regions = regions
			self.tracks = tracks
			self.artists = artists
			self.albums = albums
			self.playlists = playlists
			self.videos = videos
		}

		public init(from decoder: any Decoder) throws {
			let container = try decoder.container(keyedBy: Yandex.Music.Objects.Best.CodingKeys.self)
			id = try container.decode(Int.self, forKey: .id)
			available = try container.decodeIfPresent(Bool.self, forKey: .available)
			availableAsRbt = try container.decodeIfPresent(Bool.self, forKey: .availableAsRbt)
			availableForPremiumUsers = try container.decodeIfPresent(Bool.self, forKey: .availableForPremiumUsers)
			lyricsAvailable = try container.decodeIfPresent(Bool.self, forKey: .lyricsAvailable)
			storageDir = try container.decodeIfPresent(String.self, forKey: .storageDir)
			durationMs = try container.decodeIfPresent(Int.self, forKey: .durationMs)
			explicit = try container.decodeIfPresent(Bool.self, forKey: .explicit)
			title = try container.decodeIfPresent(String.self, forKey: .title)
			regions = try container.decodeIfPresent(SafeDecodeArray<CountryCode>.self, forKey: .regions).map { Set($0) } ?? []
			tracks = try container.decodeIfPresent(SafeDecodeArray<Yandex.Music.Objects.Track>.self, forKey: .tracks)?.array ?? []
			artists = try container.decodeIfPresent(SafeDecodeArray<Yandex.Music.Objects.Artist>.self, forKey: .artists)?.array ?? []
			albums = try container.decodeIfPresent(SafeDecodeArray<Yandex.Music.Objects.Album>.self, forKey: .albums)?.array ?? []
			playlists = try container.decodeIfPresent(SafeDecodeArray<Yandex.Music.Objects.Playlist<Yandex.Music.Objects.TrackShort>>.self, forKey: .playlists)?.array ?? []
			videos = try container.decodeIfPresent(SafeDecodeArray<Yandex.Music.Objects.Video>.self, forKey: .videos)?.array ?? []
		}
	}

	struct Track: Codable, Hashable {
		public let id: String
		public let available: Bool?
		public let availableAsRbt: Bool?
		public let availableForPremiumUsers: Bool?
		public let lyricsAvailable: Bool?
		public let albums: [Album]
		public let storageDir: String?
		public let durationMs: Int?
		public let explicit: Bool?
		public let title: String?
		public let canPublish: Bool?
		public let filename: String?
		public let artists: [Artist]
		public let regions: Set<CountryCode>
		public let version: String?
		public let contentWarning: String?
		public let coverUri: String?
		public var short: TrackShort { TrackShort(timestamp: nil, id: id, albumId: albums.first?.id) }

		public init(
			id: String,
			available: Bool?,
			availableAsRbt: Bool?,
			availableForPremiumUsers: Bool?,
			lyricsAvailable: Bool?,
			albums: [Album] = [],
			storageDir: String?,
			durationMs: Int?,
			explicit: Bool?,
			title: String?,
			artists: [Artist] = [],
			regions: Set<CountryCode> = [],
			version: String?,
			contentWarning: String?,
			coverUri: String?,
			canPublish: Bool? = nil,
			filename: String? = nil
		) {
			self.id = id
			self.available = available
			self.availableAsRbt = availableAsRbt
			self.availableForPremiumUsers = availableForPremiumUsers
			self.lyricsAvailable = lyricsAvailable
			self.albums = albums
			self.storageDir = storageDir
			self.durationMs = durationMs
			self.explicit = explicit
			self.title = title
			self.artists = artists
			self.regions = regions
			self.version = version
			self.contentWarning = contentWarning
			self.coverUri = coverUri
			self.filename = filename
			self.canPublish = canPublish
		}

		public init(from decoder: any Decoder) throws {
			let container = try decoder.container(keyedBy: Yandex.Music.Objects.Track.CodingKeys.self)
			do {
				id = try container.decode(String.self, forKey: .id)
			} catch {
				id = try "\(container.decode(Int.self, forKey: .id))"
			}
			available = try? container.decodeIfPresent(Bool.self, forKey: .available)
			availableAsRbt = try? container.decodeIfPresent(Bool.self, forKey: .availableAsRbt)
			availableForPremiumUsers = try? container.decodeIfPresent(Bool.self, forKey: .availableForPremiumUsers)
			lyricsAvailable = try? container.decodeIfPresent(Bool.self, forKey: .lyricsAvailable)
			albums = (try? container.decodeIfPresent([Yandex.Music.Objects.Album].self, forKey: .albums)) ?? []
			storageDir = try? container.decodeIfPresent(String.self, forKey: .storageDir)
			durationMs = try? container.decodeIfPresent(Int.self, forKey: .durationMs)
			explicit = try? container.decodeIfPresent(Bool.self, forKey: .explicit)
			title = try? container.decodeIfPresent(String.self, forKey: .title)
			artists = (try? container.decodeIfPresent([Yandex.Music.Objects.Artist].self, forKey: .artists)) ?? []
			regions = (try? container.decodeIfPresent(SafeDecodeArray<CountryCode>.self, forKey: .regions)).map { Set($0.array) } ?? []
			version = try? container.decodeIfPresent(String.self, forKey: .version)
			contentWarning = try? container.decodeIfPresent(String.self, forKey: .contentWarning)
			coverUri = try? container.decodeIfPresent(String.self, forKey: .coverUri)
			filename = try? container.decodeIfPresent(String.self, forKey: .filename)
			canPublish = try? container.decodeIfPresent(Bool.self, forKey: .canPublish)
		}

		public func hash(into hasher: inout Hasher) {
			id.hash(into: &hasher)
		}

		public static func == (_ lhs: Track, _ rhs: Track) -> Bool {
			lhs.id == rhs.id
		}

		public var link: URL? {
			guard let albumID = albums.first?.id else { return nil }
			return URL(string: "https://music.yandex.ru/album/\(albumID)/track/\(id)")
		}

		//        public var artists:
		//        public var albums:
		//        public var real_id=None
		//        public var og_image=None,
		//        public var type=None,
		//        public var cover_uri=None,
		//        public var major=None,
		//        public var duration_ms=None,
		//        public var storage_dir=None,
		//        public var file_size=None,
		//        public var normalization=None,
		//        public var error=None,
		//        public var regions=None,
		//        public var available_as_rbt=None,
		//        public var content_warning=None,
		//        public var explicit=None
		//        public var preview_duration_ms=None
		//        public var available_full_without_permission=None
		//        public var client=None
	}

	struct Artist: Codable {
		public let id: Int
		public var name: String
		public var cover: Cover?
		public var compose: Bool?
		public var composer: Bool?
		public var various: Bool?
		public var counts: Counts?
		public var genres: [String] // ["foreignrap"],
		public var ticketsAvailable: Bool?
		public var available: Bool?
		public var regions: Set<CountryCode>?
		public var decomposed: [JSON]
		public var popularTracks: [Track]
		public var ratings: [String: Int]?
		// avatars.yandex.net/get-music-content/4384958/2359cb95.a.15774547-1/%%
		public var ogImage: String?
		// disclaimers
		// links

		//        op_image=None,
		//        no_pictures_from_search=None,
		//        available=None,
		//        ratings=None,
		//        links=None,
		//        tickets_available=None,
		//        likes_count=None,
		//        full_names=None,
		//        description=None,
		//        countries=None,
		//        en_wikipedia_link=None,
		//        db_aliases=None,
		//        aliases=None,
		//        init_date=None,
		//        end_date=None,
		//        #warning("properties")

		public init(id: Int, name: String, cover: Cover? = nil, compose: Bool? = nil, composer: Bool? = nil, various: Bool? = nil, counts: Counts? = nil, genres: [String] = [], ticketsAvailable: Bool? = nil, available: Bool? = nil, regions: Set<CountryCode>? = nil, decomposed: [JSON] = [], popularTracks: [Track] = []) {
			self.id = id
			self.name = name
			self.cover = cover
			self.compose = compose
			self.composer = composer
			self.various = various
			self.counts = counts
			self.genres = genres
			self.ticketsAvailable = ticketsAvailable
			self.regions = regions
			self.available = available
			self.decomposed = decomposed
			self.popularTracks = popularTracks
		}

		public init(from decoder: any Decoder) throws {
			let container = try decoder.container(keyedBy: Yandex.Music.Objects.Artist.CodingKeys.self)
			id = try container.decode(Int.self, forKey: .id)
			name = try container.decode(String.self, forKey: .name)
			cover = try container.decodeIfPresent(Yandex.Music.Objects.Cover.self, forKey: .cover)
			compose = try container.decodeIfPresent(Bool.self, forKey: .compose)
			composer = try container.decodeIfPresent(Bool.self, forKey: .composer)
			various = try container.decodeIfPresent(Bool.self, forKey: .various)
			counts = try container.decodeIfPresent(Yandex.Music.Objects.Counts.self, forKey: .counts)
			genres = try container.decodeIfPresent(SafeDecodeArray<String>.self, forKey: .genres)?.array ?? []
			ticketsAvailable = try container.decodeIfPresent(Bool.self, forKey: .ticketsAvailable)
			available = try container.decodeIfPresent(Bool.self, forKey: .available)
			regions = try container.decodeIfPresent(SafeDecodeArray<CountryCode>.self, forKey: .regions).map { Set($0) }
			decomposed = try container.decodeIfPresent(SafeDecodeArray<JSON>.self, forKey: .decomposed)?.array ?? []
			popularTracks = try container.decodeIfPresent(SafeDecodeArray<Yandex.Music.Objects.Track>.self, forKey: .popularTracks)?.array ?? []
		}
	}

	struct Album: Codable {
		public let id: Int
		public var type: String?
		public var storageDir: String?
		public var originalReleaseYear: Int?
		public var year: Int?
		public var artists: [Artist]
		public var coverUri: String? // avatars.yandex.net/get-music-content/118603/eb22a71b.a.5331102-1/%%
		public var trackCount: Int?
		public var genre: String? // "foreignrap",
		public var available: Bool?
		public var availableForPremiumUsers: Bool?
		public var title: String
		public var regions: Set<CountryCode>
		public var contentWarning: String?
		public var version: String?
		public var trackPosition: TrackPosition?

		public init(id: Int, type: String? = nil, storageDir: String? = nil, originalReleaseYear: Int? = nil, year: Int? = nil, artists: [Artist] = [], coverUri: String? = nil, trackCount: Int? = nil, genre: String? = nil, available: Bool? = nil, availableForPremiumUsers: Bool? = nil, title: String, regions: Set<CountryCode> = [], contentWarning: String? = nil, version: String? = nil, trackPosition: TrackPosition? = nil) {
			self.id = id
			self.type = type
			self.storageDir = storageDir
			self.originalReleaseYear = originalReleaseYear
			self.year = year
			self.artists = artists
			self.coverUri = coverUri
			self.trackCount = trackCount
			self.genre = genre
			self.available = available
			self.availableForPremiumUsers = availableForPremiumUsers
			self.title = title
			self.regions = regions
			self.contentWarning = contentWarning
			self.version = version
			self.trackPosition = trackPosition
		}

		public init(from decoder: any Decoder) throws {
			let container = try decoder.container(keyedBy: Yandex.Music.Objects.Album.CodingKeys.self)
			id = try container.decode(Int.self, forKey: .id)
			type = try container.decodeIfPresent(String.self, forKey: .type)
			storageDir = try container.decodeIfPresent(String.self, forKey: .storageDir)
			originalReleaseYear = try container.decodeIfPresent(Int.self, forKey: .originalReleaseYear)
			year = try container.decodeIfPresent(Int.self, forKey: .year)
			artists = try container.decodeIfPresent(SafeDecodeArray<Yandex.Music.Objects.Artist>.self, forKey: .artists)?.array ?? []
			coverUri = try container.decodeIfPresent(String.self, forKey: .coverUri)
			trackCount = try container.decodeIfPresent(Int.self, forKey: .trackCount)
			genre = try container.decodeIfPresent(String.self, forKey: .genre)
			available = try container.decodeIfPresent(Bool.self, forKey: .available)
			availableForPremiumUsers = try container.decodeIfPresent(Bool.self, forKey: .availableForPremiumUsers)
			title = try container.decode(String.self, forKey: .title)
			regions = try container.decodeIfPresent(SafeDecodeArray<CountryCode>.self, forKey: .regions).map { Set($0.array) } ?? []
			contentWarning = try container.decodeIfPresent(String.self, forKey: .contentWarning)
			version = try container.decodeIfPresent(String.self, forKey: .version)
			trackPosition = try container.decodeIfPresent(Yandex.Music.Objects.TrackPosition.self, forKey: .trackPosition)
		}
	}

	struct Video: Codable {
		public var youtubeUrl: String? // "http://www.youtube.com/watch?v=0OWj0CiM8WU",
		public var thumbnailUrl: String? // "https://avatars.mds.yandex.net/get-vthumb/987623/5e4ccfd73f050596f889a99a6dfa1583/%%x%%",
		public var title: String
		public var duration: Int?
		public var text: String?
		public var htmlAutoPlayVideoPlayer: String?
		// "<iframe src=\"//www.youtube.com/embed/0OWj0CiM8WU?autoplay=1&amp;enablejsapi=1&amp;wmode=opaque\" frameborder=\"0\" scrolling=\"no\" allowfullscreen=\"1\" allow=\"autoplay; fullscreen; accelerometer; gyroscope; picture-in-picture\" aria-label=\"Video\"></iframe>",
		public var regions: Set<CountryCode>?
		
		public init(youtubeUrl: String? = nil, thumbnailUrl: String? = nil, title: String, duration: Int? = nil, text: String? = nil, htmlAutoPlayVideoPlayer: String? = nil, regions: Set<CountryCode>? = nil) {
			self.youtubeUrl = youtubeUrl
			self.thumbnailUrl = thumbnailUrl
			self.title = title
			self.duration = duration
			self.text = text
			self.htmlAutoPlayVideoPlayer = htmlAutoPlayVideoPlayer
			self.regions = regions
		}
	}

	struct TrackPosition: Codable, Sendable {
		public var volume: Int?
		public var index: Int?
		
		public init(volume: Int? = nil, index: Int? = nil) {
			self.volume = volume
			self.index = index
		}
	}

	struct Cover: Codable, Sendable {
		public let type: String?
		public let uri: String?
		public let custom: Bool?
		public let dir: String?
		public let version: String?
		public let itemsUri: [String]?
		public var prefix: String?
		
		public init(type: String?, uri: String?, custom: Bool?, dir: String?, version: String?, itemsUri: [String]?, prefix: String? = nil) {
			self.type = type
			self.uri = uri
			self.custom = custom
			self.dir = dir
			self.version = version
			self.itemsUri = itemsUri
			self.prefix = prefix
		}
	}

	struct Counts: Codable, Sendable {
		public let tracks: Int?
		public let directAlbums: Int?
		public let alsoAlbumspublic: Int?
		public let alsoTracks: Int?
		
		public init(tracks: Int?, directAlbums: Int?, alsoAlbumspublic: Int?, alsoTracks: Int?) {
			self.tracks = tracks
			self.directAlbums = directAlbums
			self.alsoAlbumspublic = alsoAlbumspublic
			self.alsoTracks = alsoTracks
		}
	}

	struct Owner: Codable, Sendable {
		public let uid: Int
		public let login: String?
		public let name: String?
		public let sex: String?
		public let verified: Bool?
		
		public init(uid: Int, login: String?, name: String?, sex: String?, verified: Bool?) {
			self.uid = uid
			self.login = login
			self.name = name
			self.sex = sex
			self.verified = verified
		}
	}

	struct Region: Codable, Sendable {

		public static let russia = Region("RUSSIA")
		public static let russiaPremium = Region("RUSSIA_PREMIUM")

		public var rawValue: String

		public init(_ value: String) {
			rawValue = value
		}

		public init(from decoder: Decoder) throws {
			self = try Self(String(from: decoder))
		}

		public func encode(to encoder: Encoder) throws {
			try rawValue.encode(to: encoder)
		}
	}

	struct Tag: Codable, Sendable {
		public let id: String
		public let value: String
		
		public init(id: String, value: String) {
			self.id = id
			self.value = value
		}
	}

	struct DownloadInfo: Codable, Sendable {
		public let codec: RawEnum<Codec>?
		public let bitrateInKbps: Int?
		public let gain, preview: Bool?
		public let downloadInfoUrl: String // URL
		public let direct: Bool?
		
		public init(codec: RawEnum<Codec>?, bitrateInKbps: Int?, gain: Bool?, preview: Bool?, downloadInfoUrl: String, direct: Bool?) {
			self.codec = codec
			self.bitrateInKbps = bitrateInKbps
			self.gain = gain
			self.preview = preview
			self.downloadInfoUrl = downloadInfoUrl
			self.direct = direct
		}
	}

	enum Codec: String, Codable, CaseIterable, Sendable {
		case mp3, aac, unknown

		public init(from decoder: Decoder) throws {
			self = try Self(rawValue: String(from: decoder)) ?? .unknown
		}
	}
}

import SwiftAPIClient

extension Yandex.Music.Objects.Track: Mockable {
	public static let mock = Yandex.Music.Objects.Track(
		id: "mock_track_id",
		available: true,
		availableAsRbt: false,
		availableForPremiumUsers: true,
		lyricsAvailable: true,
		albums: [Yandex.Music.Objects.Album.mock],
		storageDir: "/music/storage",
		durationMs: 180_000,
		explicit: false,
		title: "Mock Song Title",
		artists: [Yandex.Music.Objects.Artist.mock],
		regions: [.RU],
		version: "original",
		contentWarning: nil,
		coverUri: "avatars.yandex.net/get-music-content/mock/cover"
	)
}

extension Yandex.Music.Objects.Artist: Mockable {
	public static let mock = Yandex.Music.Objects.Artist(
		id: 123_456,
		name: "Mock Artist",
		cover: Yandex.Music.Objects.Cover.mock,
		compose: false,
		composer: false,
		various: false,
		counts: Yandex.Music.Objects.Counts.mock,
		genres: ["pop", "rock"],
		ticketsAvailable: true,
		available: true,
		regions: [.RU],
		decomposed: [],
		popularTracks: []
	)
}

extension Yandex.Music.Objects.Album: Mockable {
	public static let mock = Yandex.Music.Objects.Album(
		id: 654_321,
		type: "single",
		storageDir: "/music/albums",
		originalReleaseYear: 2023,
		year: 2023,
		artists: [],
		coverUri: "avatars.yandex.net/get-music-content/mock/album_cover",
		trackCount: 10,
		genre: "pop",
		available: true,
		availableForPremiumUsers: true,
		title: "Mock Album",
		regions: [.RU],
		contentWarning: nil,
		version: "deluxe",
		trackPosition: Yandex.Music.Objects.TrackPosition.mock
	)
}

extension Yandex.Music.Objects.DownloadInfo: Mockable {
	public static let mock = Yandex.Music.Objects.DownloadInfo(
		codec: RawEnum<Yandex.Music.Objects.Codec>(.mp3),
		bitrateInKbps: 320,
		gain: true,
		preview: false,
		downloadInfoUrl: "https://storage.mds.yandex.net/get-music-content/mock_download_url",
		direct: true
	)
}

extension Yandex.Music.Objects.Cover: Mockable {
	public static let mock = Yandex.Music.Objects.Cover(
		type: "from-artist-photos",
		uri: "avatars.yandex.net/get-music-content/mock/cover_uri",
		custom: false,
		dir: "/covers",
		version: "v1",
		itemsUri: ["avatars.yandex.net/get-music-content/mock/item1"],
		prefix: "avatars.yandex.net"
	)
}

extension Yandex.Music.Objects.Counts: Mockable {
	public static let mock = Yandex.Music.Objects.Counts(
		tracks: 50,
		directAlbums: 10,
		alsoAlbumspublic: 15,
		alsoTracks: 25
	)
}

extension Yandex.Music.Objects.TrackPosition: Mockable {
	public static let mock = Yandex.Music.Objects.TrackPosition(
		volume: 1,
		index: 5
	)
}

extension Yandex.Music.Objects.Owner: Mockable {
	public static let mock = Yandex.Music.Objects.Owner(
		uid: 123_456_789,
		login: "mockuser",
		name: "Mock User",
		sex: "male",
		verified: false
	)
}

extension Yandex.Music.Objects.Tag: Mockable {
	public static let mock = Yandex.Music.Objects.Tag(
		id: "mock_tag_id",
		value: "pop"
	)
}
