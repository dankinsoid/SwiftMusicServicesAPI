import Foundation

public extension AppleMusic.Objects {
	enum ItemType: Codable {
		case songs(Song), musicVideos(MusicVideo), librarySongs(Song), libraryMusicVideos(MusicVideo), libraryPlaylists(Playlist), playlists(Playlist)

		public var kind: AppleMusic.TrackType {
			switch self {
			case .songs: return .songs
			case .musicVideos: return .musicVideos
			case .librarySongs: return .librarySongs
			case .libraryMusicVideos: return .libraryMusicVideos
			case .libraryPlaylists: return .libraryPlaylists
			case .playlists: return .playlists
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
}
