import Foundation
import SwiftHttp

public extension Spotify.API {
	/// https://developer.spotify.com/documentation/web-api/reference/playlists/get-a-list-of-current-users-playlists/
	func playlists(
		limit: Int? = 50,
		offset: Int? = 0
	) throws -> AsyncThrowingStream<[SPPlaylistSimplified], Error> {
		try pagingRequest(
			output: SPPaging<SPPlaylistSimplified>.self,
			executor: dataTask,
			url: v1BaseURL.path("me", "playlists").query(from: PlaylistsInput(limit: limit, offset: offset)),
			method: .get,
			parameters: (),
			headers: headers()
		)
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
		limit: Int? = 100,
		offset: Int? = 0,
		market: String? = nil
	) throws -> AsyncThrowingStream<[SPPlaylistTrack], Error> {
		try pagingRequest(
			output: SPPaging<SPPlaylistTrack>.self,
			executor: dataTask,
			url: v1BaseURL.path("playlists", id, "tracks").query(from: SavedInput(limit: limit, offset: offset, market: market)),
			method: .get,
			parameters: (),
			headers: headers()
		)
	}

	func playlist(
		id: String,
		input: PlaylistInput
	) async throws -> SPPlaylist {
		try await decodableRequest(
			executor: dataTask,
			url: v1BaseURL.path("playlists", id).query(from: input),
			method: .get,
			headers: headers()
		)
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
		try await codableRequest(
			executor: dataTask,
			url: v1BaseURL.path("playlists", id, "tracks"),
			method: .post,
			headers: headers(),
			body: input
		)
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
		public var snapshotId: String
	}

	/// https://developer.spotify.com/documentation/web-api/reference/playlists/add-tracks-to-playlist/
	func createPlaylist(
		userId: String,
		input: CreatePlaylistInput
	) async throws -> SPPlaylist {
		try await codableRequest(
			executor: dataTask,
			url: v1BaseURL.path("users", userId, "playlists"),
			method: .post,
			headers: headers(with: [.contentType: "application/json"]),
			body: input
		)
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
