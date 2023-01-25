import Foundation

public extension AppleMusic {
	enum Objects {}

	enum TrackType: String, Codable, CaseIterable {
        
		case songs, musicVideos = "music-videos", librarySongs = "library-songs", libraryMusicVideos = "library-music-videos", libraryPlaylists = "library-playlists", playlists, unknown
        
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
