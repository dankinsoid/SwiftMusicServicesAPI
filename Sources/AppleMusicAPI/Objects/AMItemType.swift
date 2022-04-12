//
// Created by Данил Войдилов on 12.04.2022.
//

import Foundation

extension AppleMusic.Objects {

	public enum ItemType: Codable {
		case songs(Song), musicVideos(MusicVideo), librarySongs(Song), libraryMusicVideos(MusicVideo), libraryPlaylists(Playlist)

		public var kind: AppleMusic.TrackType {
			switch self {
			case .songs:                return .songs
			case .musicVideos:          return .musicVideos
			case .librarySongs:         return .librarySongs
			case .libraryMusicVideos:   return .libraryMusicVideos
			case .libraryPlaylists:     return .libraryPlaylists
			}
		}
		enum CodingKeys: String, CodingKey {
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
			}
		}

		public func encode(to encoder: Encoder) throws {
			var container = encoder.container(keyedBy: CodingKeys.self)
			try container.encode(kind, forKey: .type)
			switch self {
			case .songs(let song):
				try container.encode(song, forKey: .attributes)
			case .musicVideos(let musicVideos):
				try container.encode(musicVideos, forKey: .attributes)
			case .librarySongs(let librarySongs):
				try container.encode(librarySongs, forKey: .attributes)
			case .libraryMusicVideos(let libraryMusicVideos):
				try container.encode(libraryMusicVideos, forKey: .attributes)
			case .libraryPlaylists(let libraryPlaylists):
				try container.encode(libraryPlaylists, forKey: .attributes)
			}
		}

		public struct Item<T: Codable>: Codable {
			public var attributes: T
			public var id: String
			public var type: AppleMusic.TrackType
			public var href: String
		}
	}

	public struct Song: Codable {}
	public struct MusicVideo: Codable {}
	public struct Playlist: Codable {}
}
