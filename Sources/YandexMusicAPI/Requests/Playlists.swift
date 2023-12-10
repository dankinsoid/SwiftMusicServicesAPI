import Foundation
import SwiftHttp
import VDCodable

public extension Yandex.Music.API {

	func playlists(userID id: Int, playlistsKinds: [Int]) async throws -> [YM.Objects.Playlist<YMO.TrackShort>] {
		try await request(
			url: baseURL.path("users", "\(id)", "playlists").query(from: PlaylistsInput(kinds: playlistsKinds), encoder: queryEncoder),
			method: .post
		)
	}

	struct PlaylistsInput: Encodable {

		public var kinds: [Int]
		public var richTracks = false
		public var mixed = true

		private enum CodingKeys: String, CodingKey, CaseIterable {

			case kinds, richTracks = "rich-tracks", mixed
		}

		public init(kinds: [Int]) {
			self.kinds = kinds
		}
	}
}

public extension Yandex.Music.API {

	func playlistsList(userID id: Int) async throws -> [YM.Objects.Playlist<YMO.TrackShort>] {
		try await request(
			url: baseURL.path("users", "\(id)", "playlists", "list"),
			method: .get
		)
	}
}

public extension Yandex.Music.API {

	func playlistsCreate(userID id: Int, title: String, visibility: YMO.Visibility = .public) async throws -> YMO.Playlist<YMO.TrackShort> {
		try await request(
			url: baseURL.path("users", "\(id)", "playlists", "create")
				.query(from: PlaylistsCreateInput(title: title, visibility: visibility), encoder: queryEncoder),
			method: .post
		)
	}

	struct PlaylistsCreateInput: Encodable {

		public var title: String
		public var visibility: YMO.Visibility = .public

		public init(title: String, visibility: YMO.Visibility = .public) {
			self.title = title
			self.visibility = visibility
		}
	}
}

public extension Yandex.Music.API {

	func playlistsChange(userID id: Int, input: PlaylistsChangeInput) async throws -> YMO.Playlist<YMO.TrackShort> {
		let encoder = URLQueryEncoder()
		encoder.nestedEncodingStrategy = .json
		encoder.trimmingSquareBrackets = false

		return try await request(
			url: baseURL.path("users", "\(id)", "playlists", "\(input.kind)", "change-relative"),
			method: .post,
            body: encoder.encodePath(input).data(using: .utf8),
            headers: [.contentType: "application/x-www-form-urlencoded"]
		)
	}

	func playlistsAdd(userID id: Int, playlistKind pid: Int?, revision: Int, tracks: [YMO.TrackShort]) async throws -> YMO.Playlist<YMO.TrackShort> {
		let input = PlaylistsChangeInput(
            kind: pid ?? 0,
            revision: revision,
            diff: [
                YM.API.PlaylistsChangeInput.Diff(
                    at: 0,
                    tracks: tracks.map {
                        YM.API.PlaylistsChangeInput.Diff.Track(
                            id: "\($0.id)",
                            albumId: $0.albumId.map { "\($0)" }
                        )
                    }
                )
            ],
            mixed: true
        )
		return try await playlistsChange(userID: id, input: input)
	}

	struct PlaylistsChangeInput: Encodable {

		public var kind: Int
		public var revision: Int
		public var diff: [Diff]
		public var mixed = false

		public struct Diff: Encodable {

			public var op = YMO.Operation.insert
			public var at: Int
			public var tracks: [Track]

			public struct Track: Encodable {

				public var id: String
				public var albumId: String?

				public init(id: String, albumId: String? = nil) {
					self.id = id
					self.albumId = albumId
				}
			}

			public init(op: YMO.Operation = YMO.Operation.insert, at: Int, tracks: [Yandex.Music.API.PlaylistsChangeInput.Diff.Track]) {
				self.op = op
				self.at = at
				self.tracks = tracks
			}
		}

		public init(kind: Int, revision: Int, diff: [Yandex.Music.API.PlaylistsChangeInput.Diff], mixed: Bool = false) {
			self.kind = kind
			self.revision = revision
			self.diff = diff
			self.mixed = mixed
		}
	}
}
