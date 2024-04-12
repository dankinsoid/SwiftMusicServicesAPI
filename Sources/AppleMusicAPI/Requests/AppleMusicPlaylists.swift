import Foundation
import SwiftHttp

public extension AppleMusic.API {

	func addPlaylist(
        name: String,
        description: String,
        tracks: [AppleMusic.Objects.ShortItem]
    ) -> AsyncThrowingStream<[AppleMusic.Objects.Item], Error> {
		addPlaylist(input: AddPlaylistInput(name: name, description: description, tracks: tracks))
	}

	func addPlaylist(input: AddPlaylistInput) -> AsyncThrowingStream<[AppleMusic.Objects.Item], Error> {
        pages { [client] in
            try await client.path("v1", "me", "library", "playlists").body(input).post()
        }
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
        try await client
            .path("v1", "me", "library", "playlists", id, "tracks")
            .body(tracks)
            .post()
	}
}

public extension AppleMusic.API {

	func getTracks(playlistID id: String) -> AsyncThrowingStream<[AppleMusic.Objects.Item], Error> {
        pages { [client] in
            try await client.path("v1", "me", "library", "playlists", id, "tracks").get()
        }
	}
}

public extension AppleMusic.API {

    /// [Documentation](https://developer.apple.com/documentation/applemusicapi/get_all_library_playlists)
    ///
    /// Fetch all the library playlists in alphabetical order.
	func getMyPlaylists(
        limit: Int? = nil,
        include: [AppleMusic.Objects.Include]? = nil
    ) throws -> AsyncThrowingStream<[AppleMusic.Objects.Item], Error> {
        pages(limit: limit) { [client] in
            try await client.path("v1", "me", "library", "playlists")
                .query(GetMyPlaylistsInput(limit: limit ?? 100, include: include))
                .get()
        }
	}

	struct GetMyPlaylistsInput: Encodable {
		public var limit: Int
		public var include: [AppleMusic.Objects.Include]?
	}
}

public extension AppleMusic.API {

	func libraryPlaylist(
        playlistID id: String,
        include: [AppleMusic.Objects.Include]? = [.tracks, .catalog]
    ) throws -> AsyncThrowingStream<[AppleMusic.Objects.Item], Error> {
        pages { [client] in
            try await client
                .path("v1", "me", "library", "playlists", id)
                .query(LibraryPlaylistInput(include: include))
                .get()
        }
	}

	struct LibraryPlaylistInput: Encodable {
		public var include: [AppleMusic.Objects.Include]? = [.tracks, .catalog]
	}
}

public extension AppleMusic.API {
	func getPlaylists(ids: [String], storefront: String) throws -> AsyncThrowingStream<[AppleMusic.Objects.Item], Error> {
        pages { [client] in
            try await client
                .path("v1", "catalog", storefront, "playlists")
                .query(GetPlaylistsInput(ids: ids))
                .get()
        }
	}

	struct GetPlaylistsInput: Encodable {
		public var ids: [String]
	}
}
