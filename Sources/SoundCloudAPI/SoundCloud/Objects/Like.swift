import Foundation
import SwiftAPIClient

public extension SoundCloud.Objects {

	struct LibraryPlaylist: Codable {

		public var date: Date?
		public var playlist: SoundCloud.Objects.Playlist? { userPlaylist ?? systemPlaylist }

		private var userPlaylist: SoundCloud.Objects.Playlist?
		private var systemPlaylist: SoundCloud.Objects.Playlist?

		public init(date: Date? = nil, playlist: SoundCloud.Objects.Playlist? = nil) {
			self.date = date
			userPlaylist = playlist
		}

		enum CodingKeys: String, CodingKey {

			case date = "created_at"
			case userPlaylist = "playlist"
			case systemPlaylist = "system_playlist"
		}
	}

	struct TrackLike: Codable {

		public var date: Date?
		public var track: SoundCloud.Objects.Track

		public init(date: Date? = nil, track: SoundCloud.Objects.Track) {
			self.date = date
			self.track = track
		}

		enum CodingKeys: String, CodingKey {

			case date = "created_at"
			case track
		}
	}
}

extension SoundCloud.Objects.LibraryPlaylist: Mockable {
	public static let mock = SoundCloud.Objects.LibraryPlaylist(
		date: Date(),
		playlist: SoundCloud.Objects.Playlist.mock
	)
}

extension SoundCloud.Objects.TrackLike: Mockable {
	public static let mock = SoundCloud.Objects.TrackLike(
		date: Date(),
		track: SoundCloud.Objects.Track.mock
	)
}
