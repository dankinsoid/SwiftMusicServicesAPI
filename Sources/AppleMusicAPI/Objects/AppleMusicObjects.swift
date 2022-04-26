//
//  Objects.swift
//  MusicImport
//
//  Created by Данил Войдилов on 18/11/2018.
//  Copyright © 2018 Данил Войдилов. All rights reserved.
//

import Foundation

extension AppleMusic {

	public enum Objects {}

	public enum TrackType: String, Codable, CaseIterable {
		case songs, musicVideos = "music-videos", librarySongs = "library-songs", libraryMusicVideos = "library-music-videos", libraryPlaylists = "library-playlists"
	}

	public enum Types: String, Codable, CaseIterable {
		case artists, albums, songs
	}
}

