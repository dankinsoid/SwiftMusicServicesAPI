import Foundation
import SwiftHttp
import SwiftMusicServicesApi
import VDCodable

public extension AppleMusic.API.AddPlaylistInput.Attributes {
	static func publicInit(
		name: String,
		description: String
	) -> Self {
		.init(
			name: name,
			description: description
		)
	}
}

public extension AppleMusic.API.AddPlaylistInput.Relationships {
	static func publicInit(
		tracks: AppleMusic.Objects.Response<AppleMusic.Objects.ShortItem>
	) -> Self {
		.init(
			tracks: tracks
		)
	}
}

public extension AppleMusic.API.GetMyPlaylistsInput {
	static func publicInit(
		limit: Int = 100,
		include: [AppleMusic.Objects.Include]? = nil
	) -> Self {
		.init(
			limit: limit,
			include: include
		)
	}
}

public extension AppleMusic.API.GetPlaylistsInput {
	static func publicInit(
		ids: [String]
	) -> Self {
		.init(
			ids: ids
		)
	}
}

public extension AppleMusic.API.LibraryPlaylistInput {
	static func publicInit(
		include: [AppleMusic.Objects.Include]? = [.tracks, .catalog]
	) -> Self {
		.init(
			include: include
		)
	}
}

public extension AppleMusic.API.MySongsInput {
	static func publicInit(
		include: [AppleMusic.Objects.Include]? = nil,
		limit: Int,
		offset: Int
	) -> Self {
		.init(
			include: include,
			limit: limit,
			offset: offset
		)
	}
}

public extension AppleMusic.API.SearchInput {
	static func publicInit(
		term: String,
		limit: Int = 15,
		offset: Int = 0,
		types: [AppleMusic.Types]
	) -> Self {
		.init(
			term: term,
			limit: limit,
			offset: offset,
			types: types
		)
	}
}

public extension AppleMusic.API.SearchResults {
	static func publicInit(
		results: AppleMusic.API.SearchResults.Songs
	) -> Self {
		.init(
			results: results
		)
	}
}

public extension AppleMusic.API.SongsByISRCInput {
	static func publicInit(
		isrcs: [String]
	) -> Self {
		.init(
			isrcs: isrcs
		)
	}
}

public extension AppleMusic.API.SongsInput {
	static func publicInit(
		ids: [String]
	) -> Self {
		.init(
			ids: ids
		)
	}
}
