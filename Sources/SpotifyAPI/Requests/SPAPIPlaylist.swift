import Foundation
import SwiftAPIClient
import Logging

public extension Spotify.API {

	/// https://developer.spotify.com/documentation/web-api/reference/playlists/get-a-list-of-current-users-playlists/
	func playlists(
		limit: Int? = nil,
		offset: Int? = 0
	) -> AsyncThrowingStream<[SPPlaylistSimplified], Error> {
        pagingRequest(
			of: SPPaging<SPPlaylistSimplified>.self,
			parameters: (),
			limit: limit
        ) { [client] in
            try await client("me", "playlists")
                .query(PlaylistsInput(limit: limit ?? 50, offset: offset))
                .get()
        }
	}

	struct PlaylistsInput: Encodable {
		public var limit: Int?
		public var offset: Int?

		public init(limit: Int? = nil, offset: Int? = nil) {
			self.limit = limit
			self.offset = offset
		}
	}

	/// https://developer.spotify.com/console/get-playlist-tracks/
	func playlistTracks(
		id: String,
		limit: Int? = nil,
		offset: Int? = 0,
		market: String? = nil
	) -> AsyncThrowingStream<[SPPlaylistTrack], Error> {
        pagingRequest(
			of: SPPaging<SPPlaylistTrack>.self,
			parameters: (),
			limit: limit
        ) { [client] in
            try await client("playlists", id, "tracks")
                .query(SavedInput(limit: limit ?? 100, offset: offset, market: market))
                .get()
        }
	}

	func playlist(
		id: String,
		input: PlaylistInput
	) async throws -> SPPlaylist {
        try await client("playlists", id).query(input).get()
	}

	struct PlaylistInput: Encodable {
		public var fields: [String]?
		public var market: String?
		public var additionalTypes: String?

		public init(fields: [String]? = nil, market: String? = nil, additionalTypes: String? = nil) {
			self.fields = fields
			self.market = market
			self.additionalTypes = additionalTypes
		}
	}

	/// https://developer.spotify.com/documentation/web-api/reference/playlists/add-tracks-to-playlist/
	@discardableResult
	func addPlaylist(
		id: String,
		input: AddPlaylistInput
	) async throws -> AddPlaylistOutput {
        try await client("playlists", id, "tracks").body(input)
            .errorHandler { error, _, context in
                if let data = context.response, let string = String(data: data, encoding: .utf8) {
                    Logger(label: "Spotify-API").error("\(string)")
                }
                throw error
            }
            .post()
	}

	struct AddPlaylistInput: Encodable {

		public var uris: [String]?
		public var position: Int?

		public init(uris: [String]? = nil, position: Int? = nil) {
			self.uris = uris
			self.position = position
		}
	}

	struct AddPlaylistOutput: Decodable {
		public var snapshotId: String?
	}

	/// https://developer.spotify.com/documentation/web-api/reference/playlists/add-tracks-to-playlist/
	func createPlaylist(
		userId: String,
		input: CreatePlaylistInput
	) async throws -> SPPlaylist {
        try await client("users", userId, "playlists")
            .body(input)
            .errorHandler { error, _, context in
                if let data = context.response, let string = String(data: data, encoding: .utf8) {
                    Logger(label: "Spotify-API").error("\(string)")
                }
                throw error
            }
            .post()
	}

	struct CreatePlaylistInput: Encodable {

		/// Required. The name for the new playlist, for example "Your Coolest Playlist" . This name does not need to be unique; a user may have several playlists with the same name.
		public var name: String
		/// Optional. Defaults to true . If true the playlist will be public, if false it will be private. To be able to create private playlists, the user must have granted the playlist-modify-private scope .
		public var `public`: Bool?
		/// Optional. Defaults to false . If true the playlist will be collaborative. Note that to create a collaborative playlist you must also set public to false . To create collaborative playlists you must have granted playlist-modify-private and playlist-modify-public scopes .
		public var collaborative: Bool?
		/// Optional. value for playlist description as displayed in Spotify Clients and in the Web API.
		public var description: String?

		public init(name: String, isPublic: Bool? = nil, collaborative: Bool? = nil, description: String? = nil) {
			self.name = name
			self.public = isPublic
			self.collaborative = collaborative
			self.description = description
		}
	}
}
