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
		public let richTracks = false
		public let mixed = true

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
	}
}

public extension Yandex.Music.API {
	func playlistsChange(userID id: Int, input: PlaylistsChangeInput) async throws -> YMO.Playlist<YMO.TrackShort> {
		let encoder = URLQueryEncoder()
		encoder.nestedEncodingStrategy = .json
		encoder.trimmingSquareBrackets = true

		return try await request(
			url: baseURL.path("users", "\(id)", "playlists", "\(input.kind)", "change").query(from: input, encoder: encoder),
			method: .post
		)
	}

	func playlistsAdd(userID id: Int, playlistKind pid: Int?, revision: Int, tracks: [YMO.TrackShort]) async throws -> YMO.Playlist<YMO.TrackShort> {
		let input = PlaylistsChangeInput(kind: pid ?? 0, revision: revision, diff: [.init(at: 0, tracks: tracks.map { .init(id: "\($0.id)", albumId: $0.albumId.map { "\($0)" }) })])
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
			}
		}
	}
}
