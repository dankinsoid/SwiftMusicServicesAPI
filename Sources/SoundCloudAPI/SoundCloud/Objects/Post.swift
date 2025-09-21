import Foundation

public extension SoundCloud.Objects {

	struct Post: Identifiable, Equatable, Codable {

		public enum Kind: Equatable {
			case track(Track)
			case trackRepost(Track)
			case playlist(Playlist)
			case playlistRepost(Playlist)
		}

		public enum Item: Equatable {
			case track(Track)
			case playlist(Playlist)
		}

		public var id: String
		public var date: Date
		public var caption: String?
		public var kind: Kind
		public var user: User

		public var isRepost: Bool {
			switch kind {
			case .trackRepost: return true
			case .playlistRepost: return true
			default: return false
			}
		}

		public var isTrack: Bool {
			switch kind {
			case .track: return true
			case .trackRepost: return true
			default: return false
			}
		}

		public var tracks: [Track] {
			switch kind {
			case let .track(track): return [track]
			case let .trackRepost(track): return [track]
			case let .playlist(playlist): fallthrough
			case let .playlistRepost(playlist): return playlist.tracks ?? []
			}
		}

		public var playlist: Playlist? {
			switch kind {
			case let .playlist(playlist): return playlist
			case let .playlistRepost(playlist): return playlist
			default: return nil
			}
		}

		public var item: Item {
			switch kind {
			case let .track(track): return .track(track)
			case let .trackRepost(track): return .track(track)
			case let .playlist(playlist): return .playlist(playlist)
			case let .playlistRepost(playlist): return .playlist(playlist)
			}
		}

		enum CodingKeys: String, CodingKey {
			case id = "uuid"
			case date = "created_at"
			case caption
			case type
			case track
			case playlist
			case user
		}

		public init(from decoder: Decoder) throws {
			let container = try decoder.container(keyedBy: CodingKeys.self)
			id = try container.decode(String.self, forKey: .id)
			date = try container.decode(Date.self, forKey: .date)
			caption = try container.decodeIfPresent(String.self, forKey: .caption)

			user = try container.decode(User.self, forKey: .user)
			let type = try container.decode(String.self, forKey: .type)
			switch type {
			case "track":
				let track = try container.decode(Track.self, forKey: .track)
				kind = .track(track)
			case "track-repost":
				let track = try container.decode(Track.self, forKey: .track)
				kind = .trackRepost(track)
			case "playlist":
				let playlist = try container.decode(Playlist.self, forKey: .playlist)
				kind = .playlist(playlist)
			case "playlist-repost":
				let playlist = try container.decode(Playlist.self, forKey: .playlist)
				kind = .playlistRepost(playlist)
			default:
				throw UndefinedPostTypeError(type: type)
			}
		}

		public func encode(to encoder: Encoder) throws {
			var container = encoder.container(keyedBy: CodingKeys.self)

			try container.encode(id, forKey: .id)
			try container.encode(date, forKey: .date)
			try container.encode(caption, forKey: .caption)
			try container.encode(caption, forKey: .caption)
			try container.encode(user, forKey: .user)

			switch kind {
			case let .track(track):
				try container.encode("track", forKey: .type)
				try container.encode(track, forKey: .track)
			case let .trackRepost(track):
				try container.encode("track-repost", forKey: .type)
				try container.encode(track, forKey: .track)
			case let .playlist(playlist):
				try container.encode("playlist", forKey: .type)
				try container.encode(playlist, forKey: .playlist)
			case let .playlistRepost(playlist):
				try container.encode("playlist-repost", forKey: .type)
				try container.encode(playlist, forKey: .playlist)
			}
		}
	}
}

public struct UndefinedPostTypeError: Error {

	public var type: String
}
