import Foundation
import SwiftAPIClient

public extension AppleMusic {
	enum Objects {}

	enum TrackType: String, Codable, CaseIterable, Sendable, CodingKeyRepresentable {

		case songs, musicVideos = "music-videos", librarySongs = "library-songs", libraryMusicVideos = "library-music-videos", libraryPlaylists = "library-playlists", playlists, storefronts, unknown, libraryAlbums = "library-albums", albums, libraryArtists = "library-artists", artists

		public init(from decoder: Decoder) throws {
			self = try TrackType(rawValue: String(from: decoder)) ?? .unknown
		}
	}

	enum Types: String, Codable, CaseIterable {
		case artists, albums, songs, unknown

		public init(from decoder: Decoder) throws {
			self = try Self(rawValue: String(from: decoder)) ?? .unknown
		}
	}
}

extension AppleMusic.TrackType: Mockable {
	public static let mock = AppleMusic.TrackType.songs
}

extension AppleMusic.Types: Mockable {
	public static let mock = AppleMusic.Types.songs
}
