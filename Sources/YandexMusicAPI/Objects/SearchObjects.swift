import Foundation
import VDCodable
import SwiftMusicServicesApi

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

		public var regions: [String]
		public var tracks: [Track]
		public var artists: [Artist]
		public var albums: [Album]
		public var playlists: [Playlist<TrackShort>]
		public var videos: [Video]
        
        public init(id: Int, available: Bool? = nil, availableAsRbt: Bool? = nil, availableForPremiumUsers: Bool? = nil, lyricsAvailable: Bool? = nil, storageDir: String? = nil, durationMs: Int? = nil, explicit: Bool? = nil, title: String? = nil, regions: [String] = [], tracks: [Track] = [], artists: [Artist] = [], albums: [Album] = [], playlists: [Playlist<TrackShort>] = [], videos: [Video] = []) {
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
            self.id = try container.decode(Int.self, forKey: .id)
            self.available = try container.decodeIfPresent(Bool.self, forKey: .available)
            self.availableAsRbt = try container.decodeIfPresent(Bool.self, forKey: .availableAsRbt)
            self.availableForPremiumUsers = try container.decodeIfPresent(Bool.self, forKey: .availableForPremiumUsers)
            self.lyricsAvailable = try container.decodeIfPresent(Bool.self, forKey: .lyricsAvailable)
            self.storageDir = try container.decodeIfPresent(String.self, forKey: .storageDir)
            self.durationMs = try container.decodeIfPresent(Int.self, forKey: .durationMs)
            self.explicit = try container.decodeIfPresent(Bool.self, forKey: .explicit)
            self.title = try container.decodeIfPresent(String.self, forKey: .title)
            self.regions = try container.decodeIfPresent(SafeDecodeArray<String>.self, forKey: .regions)?.array ?? []
            self.tracks = try container.decodeIfPresent(SafeDecodeArray<Yandex.Music.Objects.Track>.self, forKey: .tracks)?.array ?? []
            self.artists = try container.decodeIfPresent(SafeDecodeArray<Yandex.Music.Objects.Artist>.self, forKey: .artists)?.array ?? []
            self.albums = try container.decodeIfPresent(SafeDecodeArray<Yandex.Music.Objects.Album>.self, forKey: .albums)?.array ?? []
            self.playlists = try container.decodeIfPresent(SafeDecodeArray<Yandex.Music.Objects.Playlist<Yandex.Music.Objects.TrackShort>>.self, forKey: .playlists)?.array ?? []
            self.videos = try container.decodeIfPresent(SafeDecodeArray<Yandex.Music.Objects.Video>.self, forKey: .videos)?.array ?? []
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
		public let regions: [String]
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
            regions: [String] = [],
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
                self.id = try container.decode(String.self, forKey: .id)
            } catch {
                self.id = try "\(container.decode(Int.self, forKey: .id))"
            }
            self.available = try? container.decodeIfPresent(Bool.self, forKey: .available)
            self.availableAsRbt = try? container.decodeIfPresent(Bool.self, forKey: .availableAsRbt)
            self.availableForPremiumUsers = try? container.decodeIfPresent(Bool.self, forKey: .availableForPremiumUsers)
            self.lyricsAvailable = try? container.decodeIfPresent(Bool.self, forKey: .lyricsAvailable)
            self.albums = (try? container.decodeIfPresent([Yandex.Music.Objects.Album].self, forKey: .albums)) ?? []
            self.storageDir = try? container.decodeIfPresent(String.self, forKey: .storageDir)
            self.durationMs = try? container.decodeIfPresent(Int.self, forKey: .durationMs)
            self.explicit = try? container.decodeIfPresent(Bool.self, forKey: .explicit)
            self.title = try? container.decodeIfPresent(String.self, forKey: .title)
            self.artists = (try? container.decodeIfPresent([Yandex.Music.Objects.Artist].self, forKey: .artists)) ?? []
            self.regions = (try? container.decodeIfPresent([String].self, forKey: .regions)) ?? []
            self.version = try? container.decodeIfPresent(String.self, forKey: .version)
            self.contentWarning = try? container.decodeIfPresent(String.self, forKey: .contentWarning)
            self.coverUri = try? container.decodeIfPresent(String.self, forKey: .coverUri)
            self.filename = try? container.decodeIfPresent(String.self, forKey: .filename)
            self.canPublish = try? container.decodeIfPresent(Bool.self, forKey: .canPublish)
        }
        
		public func hash(into hasher: inout Hasher) {
			id.hash(into: &hasher)
		}

		public static func == (_ lhs: Track, _ rhs: Track) -> Bool {
			lhs.id == rhs.id
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
		public var regions: [String]
		public var decomposed: [JSON]
		public var popularTracks: [Track]

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
        
        public init(id: Int, name: String, cover: Cover? = nil, compose: Bool? = nil, composer: Bool? = nil, various: Bool? = nil, counts: Counts? = nil, genres: [String] = [], ticketsAvailable: Bool? = nil, regions: [String] = [], decomposed: [JSON] = [], popularTracks: [Track] = []) {
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
            self.decomposed = decomposed
            self.popularTracks = popularTracks
        }

        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: Yandex.Music.Objects.Artist.CodingKeys.self)
            self.id = try container.decode(Int.self, forKey: .id)
            self.name = try container.decode(String.self, forKey: .name)
            self.cover = try container.decodeIfPresent(Yandex.Music.Objects.Cover.self, forKey: .cover)
            self.compose = try container.decodeIfPresent(Bool.self, forKey: .compose)
            self.composer = try container.decodeIfPresent(Bool.self, forKey: .composer)
            self.various = try container.decodeIfPresent(Bool.self, forKey: .various)
            self.counts = try container.decodeIfPresent(Yandex.Music.Objects.Counts.self, forKey: .counts)
            self.genres = try container.decodeIfPresent(SafeDecodeArray<String>.self, forKey: .genres)?.array ?? []
            self.ticketsAvailable = try container.decodeIfPresent(Bool.self, forKey: .ticketsAvailable)
            self.regions = try container.decodeIfPresent(SafeDecodeArray<String>.self, forKey: .regions)?.array ?? []
            self.decomposed = try container.decodeIfPresent(SafeDecodeArray<JSON>.self, forKey: .decomposed)?.array ?? []
            self.popularTracks = try container.decodeIfPresent(SafeDecodeArray<Yandex.Music.Objects.Track>.self, forKey: .popularTracks)?.array ?? []
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
        public var regions: [String]
        public var contentWarning: String?
        public var version: String?
        public var trackPosition: TrackPosition?
        
        public init(id: Int, type: String? = nil, storageDir: String? = nil, originalReleaseYear: Int? = nil, year: Int? = nil, artists: [Artist] = [], coverUri: String? = nil, trackCount: Int? = nil, genre: String? = nil, available: Bool? = nil, availableForPremiumUsers: Bool? = nil, title: String, regions: [String] = [], contentWarning: String? = nil, version: String? = nil, trackPosition: TrackPosition? = nil) {
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
            self.id = try container.decode(Int.self, forKey: .id)
            self.type = try container.decodeIfPresent(String.self, forKey: .type)
            self.storageDir = try container.decodeIfPresent(String.self, forKey: .storageDir)
            self.originalReleaseYear = try container.decodeIfPresent(Int.self, forKey: .originalReleaseYear)
            self.year = try container.decodeIfPresent(Int.self, forKey: .year)
            self.artists = try container.decodeIfPresent(SafeDecodeArray<Yandex.Music.Objects.Artist>.self, forKey: .artists)?.array ?? []
            self.coverUri = try container.decodeIfPresent(String.self, forKey: .coverUri)
            self.trackCount = try container.decodeIfPresent(Int.self, forKey: .trackCount)
            self.genre = try container.decodeIfPresent(String.self, forKey: .genre)
            self.available = try container.decodeIfPresent(Bool.self, forKey: .available)
            self.availableForPremiumUsers = try container.decodeIfPresent(Bool.self, forKey: .availableForPremiumUsers)
            self.title = try container.decode(String.self, forKey: .title)
            self.regions = try container.decodeIfPresent(SafeDecodeArray<String>.self, forKey: .regions)?.array ?? []
            self.contentWarning = try container.decodeIfPresent(String.self, forKey: .contentWarning)
            self.version = try container.decodeIfPresent(String.self, forKey: .version)
            self.trackPosition = try container.decodeIfPresent(Yandex.Music.Objects.TrackPosition.self, forKey: .trackPosition)
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
		public var regions: [String]?
	}

	struct TrackPosition: Codable {
		public var volume: Int?
		public var index: Int?
	}

	struct Cover: Codable {
		public let type: String?
		public let uri: String?
		public let custom: Bool?
		public let dir: String?
		public let version: String?
		public let itemsUri: [String]?
		public var prefix: String?
	}

	struct Counts: Codable {
		public let tracks: Int
		public let tdirectAlbums: Int
		public let talsoAlbumspublic: Int
		public let talsoTracks: Int
	}

	struct Owner: Codable {
		public let uid: Int
		public let login: String?
		public let name: String?
		public let sex: String?
		public let verified: Bool?
	}

	struct Region: Codable {

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

	struct Tag: Codable {
		public let id: String
		public let value: String
	}

	struct DownloadInfo: Codable {
		public let codec: RawEnum<Codec>?
		public let bitrateInKbps: Int?
		public let gain, preview: Bool?
		public let downloadInfoUrl: String // URL
		public let direct: Bool?
	}

	enum Codec: String, Codable, CaseIterable {
		case mp3, aac, unknown

		public init(from decoder: Decoder) throws {
			self = try Self(rawValue: String(from: decoder)) ?? .unknown
		}
	}
}
