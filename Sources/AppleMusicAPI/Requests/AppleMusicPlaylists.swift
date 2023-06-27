import Foundation
import SwiftHttp

public extension AppleMusic.API {
	func addPlaylist(name: String, description: String, tracks: [AppleMusic.Objects.ShortItem]) -> AsyncThrowingStream<[AppleMusic.Objects.Item], Error> {
		addPlaylist(input: AddPlaylistInput(name: name, description: description, tracks: tracks))
	}

	func addPlaylist(input: AddPlaylistInput) -> AsyncThrowingStream<[AppleMusic.Objects.Item], Error> {
		return dataRequest(
			url: baseURL.path("v1", "me", "library", "playlists"),
			method: .post,
			body: input
		)
	}

	struct AddPlaylistInput: Encodable {
		public var attributes: Attributes
		public var relationships: Relationships

		public init(name: String, description: String, tracks: [AppleMusic.Objects.ShortItem]) {
			attributes = Attributes(name: name, description: description)
			relationships = Relationships(tracks: .init(data: tracks))
		}

		public init(name: String, description: String, trackIDs: Set<String>) {
			attributes = Attributes(name: name, description: description)
			relationships = Relationships(tracks: .init(data: trackIDs.map { AppleMusic.Objects.ShortItem(id: $0, type: .songs) }))
		}

		public init(attributes: AppleMusic.API.AddPlaylistInput.Attributes, relationships: AppleMusic.API.AddPlaylistInput.Relationships) {
			self.attributes = attributes
			self.relationships = relationships
		}

		public struct Relationships: Codable {
			public var tracks: AppleMusic.Objects.Response<AppleMusic.Objects.ShortItem>
		}

		public struct Attributes: Encodable {
			public var name: String
			public var description: String
		}
	}
}

public extension AppleMusic.API {
	func addTracks(playlistID id: String, tracks: AppleMusic.Objects.Response<AppleMusic.Objects.Item>) async throws {
		_ = try await encodableRequest(
			executor: client.dataTask,
			url: baseURL.path("v1", "me", "library", "playlists", id, "tracks"),
			method: .post,
			headers: headers(),
			body: tracks
		)
	}
}

public extension AppleMusic.API {
	func getTracks(playlistID id: String) -> AsyncThrowingStream<[AppleMusic.Objects.Item], Error> {
		dataRequest(
			url: baseURL.path("v1", "me", "library", "playlists", id, "tracks")
		)
	}
}

public extension AppleMusic.API {
	func getMyPlaylists(limit: Int? = nil, include: [AppleMusic.Objects.Include]? = nil) throws -> AsyncThrowingStream<[AppleMusic.Objects.Item], Error> {
		return try dataRequest(
			url: baseURL.path("v1", "me", "library", "playlists").query(from: GetMyPlaylistsInput(limit: limit ?? 100, include: include)),
            limit: limit
		)
	}

	struct GetMyPlaylistsInput: Encodable {
        public var limit: Int
		public var include: [AppleMusic.Objects.Include]?
	}
}

public extension AppleMusic.API {
	func libraryPlaylist(playlistID id: String, include: [AppleMusic.Objects.Include]? = [.tracks, .catalog]) throws -> AsyncThrowingStream<[AppleMusic.Objects.Item], Error> {
		try dataRequest(
			url: baseURL.path("v1", "me", "library", "playlists", id).query(from: LibraryPlaylistInput(include: include))
		)
	}

	struct LibraryPlaylistInput: Encodable {
		public var include: [AppleMusic.Objects.Include]? = [.tracks, .catalog]
	}
}

public extension AppleMusic.API {
	func getPlaylists(ids: [String], storefront: String) throws -> AsyncThrowingStream<[AppleMusic.Objects.Item], Error> {
		try dataRequest(
			url: baseURL.path("v1", "catalog", storefront, "playlists").query(from: GetPlaylistsInput(ids: ids))
		)
	}

	struct GetPlaylistsInput: Encodable {
		public var ids: [String]
	}
}
