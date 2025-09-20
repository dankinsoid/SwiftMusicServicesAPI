import Foundation
import SwiftAPIClient

public extension AppleMusic.Objects {

	enum ItemType: Codable {
		case songs(Song), musicVideos(MusicVideo), librarySongs(Song), libraryMusicVideos(MusicVideo), libraryPlaylists(Playlist), playlists(Playlist), storefront(Attributes.Storefront), libraryAlbums(Album), albums(Album), libraryArtists(Artist), artists(Artist)

		public var kind: AppleMusic.TrackType {
			switch self {
			case .songs: return .songs
			case .musicVideos: return .musicVideos
			case .librarySongs: return .librarySongs
			case .libraryMusicVideos: return .libraryMusicVideos
			case .libraryPlaylists: return .libraryPlaylists
			case .playlists: return .playlists
			case .storefront: return .storefronts
			case .libraryAlbums: return .libraryAlbums
			case .albums: return .albums
			case .libraryArtists: return .libraryArtists
			case .artists: return .artists
			}
		}

		enum CodingKeys: String, CodingKey, CaseIterable {
			case attributes, id, type, href
		}

		public init(from decoder: Decoder) throws {
			let container = try decoder.container(keyedBy: CodingKeys.self)
			let type = try container.decode(AppleMusic.TrackType.self, forKey: .type)
			switch type {
			case .songs:
				let song = try container.decode(Song.self, forKey: .attributes)
				self = .songs(song)
			case .musicVideos:
				let song = try container.decode(MusicVideo.self, forKey: .attributes)
				self = .musicVideos(song)
			case .librarySongs:
				let song = try container.decode(Song.self, forKey: .attributes)
				self = .librarySongs(song)
			case .libraryMusicVideos:
				let song = try container.decode(MusicVideo.self, forKey: .attributes)
				self = .libraryMusicVideos(song)
			case .libraryPlaylists:
				let song = try container.decode(Playlist.self, forKey: .attributes)
				self = .libraryPlaylists(song)
			case .playlists:
				let song = try container.decode(Playlist.self, forKey: .attributes)
				self = .playlists(song)
			case .storefronts:
				let storefront = try container.decode(Attributes.Storefront.self, forKey: .attributes)
				self = .storefront(storefront)
			case .libraryAlbums:
				let album = try container.decode(Album.self, forKey: .attributes)
				self = .libraryAlbums(album)
			case .albums:
				let album = try container.decode(Album.self, forKey: .attributes)
				self = .albums(album)
			case .libraryArtists:
				let artist = try container.decode(Artist.self, forKey: .attributes)
				self = .libraryArtists(artist)
			case .artists:
				let artist = try container.decode(Artist.self, forKey: .attributes)
				self = .artists(artist)
			case .unknown:
				throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "unknown track type"))
			}
		}

		public func encode(to encoder: Encoder) throws {
			var container = encoder.container(keyedBy: CodingKeys.self)
			try container.encode(kind, forKey: .type)
			switch self {
			case let .songs(song):
				try container.encode(song, forKey: .attributes)
			case let .musicVideos(musicVideos):
				try container.encode(musicVideos, forKey: .attributes)
			case let .librarySongs(librarySongs):
				try container.encode(librarySongs, forKey: .attributes)
			case let .libraryMusicVideos(libraryMusicVideos):
				try container.encode(libraryMusicVideos, forKey: .attributes)
			case let .libraryPlaylists(libraryPlaylists):
				try container.encode(libraryPlaylists, forKey: .attributes)
			case let .playlists(playlists):
				try container.encode(playlists, forKey: .attributes)
			case let .storefront(storefront):
				try container.encode(storefront, forKey: .attributes)
			case let .libraryAlbums(libraryAlbums):
				try container.encode(libraryAlbums, forKey: .attributes)
			case let .albums(albums):
				try container.encode(albums, forKey: .attributes)
			case let .libraryArtists(libraryArtists):
				try container.encode(libraryArtists, forKey: .attributes)
			case let .artists(artists):
				try container.encode(artists, forKey: .attributes)
			}
		}

		public struct Item<T: Codable>: Codable {
			public init(attributes: T, id: String, type: AppleMusic.TrackType, href: String) {
				self.attributes = attributes
				self.id = id
				self.type = type
				self.href = href
			}

			public var attributes: T
			public var id: String
			public var type: AppleMusic.TrackType
			public var href: String
		}
	}

	struct Song: Codable {
		public init() {}
	}

	struct MusicVideo: Codable {
		public init() {}
	}

	struct Playlist: Codable {
		public init() {}
	}
	
	struct Album: Codable {
		public init() {}
	}
	
	struct Artist: Codable {
		public init() {}
	}
}

extension AppleMusic.Objects.ItemType.Item: Sendable where T: Sendable {}

public extension AppleMusic.Objects.Attributes {

	struct Storefront: Equatable, Codable {

		public var name: String?
		public var supportedLanguageTags: [String]?
		public var defaultLanguageTag: String?

		public init(name: String? = nil, supportedLanguageTags: [String]? = nil, defaultLanguageTag: String?) {
			self.name = name
			self.supportedLanguageTags = supportedLanguageTags
			self.defaultLanguageTag = defaultLanguageTag
		}
	}
}

extension AppleMusic.Objects.ItemType: Mockable {
	public static let mock = AppleMusic.Objects.ItemType.songs(AppleMusic.Objects.Song.mock)
}

extension AppleMusic.Objects.Song: Mockable {
	public static let mock = AppleMusic.Objects.Song()
}

extension AppleMusic.Objects.MusicVideo: Mockable {
	public static let mock = AppleMusic.Objects.MusicVideo()
}

extension AppleMusic.Objects.Playlist: Mockable {
	public static let mock = AppleMusic.Objects.Playlist()
}

extension AppleMusic.Objects.Attributes.Storefront: Mockable {
	public static let mock = AppleMusic.Objects.Attributes.Storefront(
		name: "Mock Storefront",
		supportedLanguageTags: ["en-US", "es-ES"],
		defaultLanguageTag: "en-US"
	)
}

extension AppleMusic.Objects.ItemType.Item: Mockable where T: Mockable {
	public static var mock: AppleMusic.Objects.ItemType.Item<T> {
		AppleMusic.Objects.ItemType.Item(
			attributes: T.mock,
			id: "mock_item_id",
			type: .songs,
			href: "https://api.music.apple.com/v1/catalog/us/songs/mock_item_id"
		)
	}
}
