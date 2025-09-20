import Foundation
import SwiftAPIClient
import SwiftMusicServicesApi

public extension Tidal.API.V1 {

	var users: Users {
		Users(client: client("users"))
	}

	struct Users {

		public let client: APIClient

		public func callAsFunction(_ id: Int) -> Tidal.API.V1.User {
			Tidal.API.V1.User(client: client(id))
		}
	}

	struct User {

		public let client: APIClient
	}
}

public extension Tidal.API.V1.User {

	func playlistsAndFavoritePlaylists(
		order: Tidal.Objects.Order? = nil,
		orderDirection: Tidal.Objects.OrderDirection? = nil,
		limit: Int? = nil,
		offset: Int = 0
	) -> TidalPaging<Tidal.Objects.UserPlaylist> {
		TidalPaging(
			client: client("playlistsAndFavoritePlaylists")
				.query(["order": order, "orderDirection": orderDirection]),
			limit: limit,
			offset: offset
		)
	}

	func get() async throws -> Tidal.Objects.User {
		try await client.get()
	}

	var favorites: Favorites {
		Favorites(client: client("favorites"))
	}

	struct Favorites {

		public let client: APIClient
	}

	var playlists: Playlists {
		Playlists(client: client("playlists"))
	}
	
	var albums: Tidal.API.V1.User.Albums {
		Tidal.API.V1.User.Albums(client: client("albums"))
	}
	
	var artists: Tidal.API.V1.User.Artists {
		Tidal.API.V1.User.Artists(client: client("artists"))
	}

	struct Playlists {

		public let client: APIClient
	}
	
	struct Albums {

		public let client: APIClient
	}
	
	struct Artists {

		public let client: APIClient
	}
}

public extension Tidal.API.V1.User.Favorites {

	var tracks: Tracks {
		Tracks(client: client("tracks"))
	}
	
	func tracks(
		order: Tidal.Objects.Order? = nil,
		orderDirection: Tidal.Objects.OrderDirection? = nil,
		limit: Int? = nil,
		offset: Int = 0
	) -> TidalPaging<TDO.UserItem<TDO.Track>> {
		TidalPaging(
			client: client("tracks")
				.query(["order": order, "orderDirection": orderDirection]),
			limit: limit,
			offset: offset
		)
	}
	
	struct Tracks {

		public let client: APIClient
	}
	
	var artists: Tidal.API.V1.User.Favorites.Artists {
		Tidal.API.V1.User.Favorites.Artists(client: client("artists"))
	}
	
	struct Artists {

		public let client: APIClient
	}
	
	func artists(
		order: Tidal.Objects.Order? = nil,
		orderDirection: Tidal.Objects.OrderDirection? = nil,
		limit: Int? = nil,
		offset: Int = 0
	) -> TidalPaging<TDO.UserItem<TDO.Artist>> {
		TidalPaging(
			client: client("artists")
				.query(["order": order, "orderDirection": orderDirection]),
			limit: limit,
			offset: offset
		)
	}
	
	var albums: Tidal.API.V1.User.Favorites.Albums {
		Tidal.API.V1.User.Favorites.Albums(client: client("albums"))
	}
	
	struct Albums {

		public let client: APIClient
	}
	
	func albums(
		order: Tidal.Objects.Order? = nil,
		orderDirection: Tidal.Objects.OrderDirection? = nil,
		limit: Int? = nil,
		offset: Int = 0
	) -> TidalPaging<TDO.UserItem<TDO.Album>> {
		TidalPaging(
			client: client("albums")
				.query(["order": order, "orderDirection": orderDirection]),
			limit: limit,
			offset: offset
		)
	}
}

extension Tidal.API.V1.User.Favorites.Artists {

	public func follow(
		ids: [Int],
		onArtifactNotFound: Tidal.Objects.NotFoundPolicy = .fail
	) async throws {
		try await client
			.body(FollowBody(artistIds: ids, onArtifactNotFound: onArtifactNotFound))
			.bodyEncoder(.formURL)
			.post()
	}
	
	private struct FollowBody: Encodable {
		
		var artistIds: [Int]
		var onArtifactNotFound: Tidal.Objects.NotFoundPolicy
	}
}

extension Tidal.API.V1.User.Favorites.Albums {

	public func add(
		ids: [Int],
		onArtifactNotFound: Tidal.Objects.NotFoundPolicy = .fail
	) async throws {
		try await client
			.body(AddBody(albumIds: ids, onArtifactNotFound: onArtifactNotFound))
			.bodyEncoder(.formURL)
			.post()
	}

	private struct AddBody: Encodable {
		
		var albumIds: [Int]
		var onArtifactNotFound: Tidal.Objects.NotFoundPolicy
	}
}

public extension Tidal.API.V1.User.Playlists {

	func create(
		title: String,
		description: String? = nil
	) async throws -> Tidal.Objects.WithETag<Tidal.Objects.Playlist> {
		let (playlist, response) = try await client
			.body(["title": title, "description": description])
			.post
			.call(
				.httpResponse,
				as: .decodable(Tidal.Objects.Playlist.self)
			)
		return Tidal.Objects.WithETag(eTag: response.headerFields[.eTag], value: playlist)
	}
}

public extension HTTPField.Name {

	static let eTag = HTTPField.Name("ETag")!
}

public extension Tidal.Objects {

	enum Order: String, Codable, CaseIterable {

		case date = "DATE"
		case name = "NAME"
		case artist = "ARTIST"
		case releaseDate = "RELEASE_DATE"
	}

	enum OrderDirection: String, Codable, CaseIterable {

		case ascending = "ASC"
		case descending = "DESC"
	}
}
