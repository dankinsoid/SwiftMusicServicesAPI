import Foundation

public extension AppleMusic {
	enum Objects {}

	enum TrackType: String, Codable, CaseIterable {
		case songs, musicVideos = "music-videos", librarySongs = "library-songs", libraryMusicVideos = "library-music-videos", libraryPlaylists = "library-playlists"
	}

	enum Types: String, Codable, CaseIterable {
		case artists, albums, songs
	}
}
