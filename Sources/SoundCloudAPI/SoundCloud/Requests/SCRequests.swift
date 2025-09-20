import Foundation
import SwiftAPIClient
import SwiftMusicServicesApi

public extension SoundCloud.API {

	func me() async throws -> SoundCloud.Objects.User { try await client.path("me").get() }
	var me: Me { Me(client: client("me")) }

	struct Me { let client: APIClient }
}

public extension SoundCloud.API.Me {

	func library(limit: Int? = nil) -> SCPaging<SCO.LibraryPlaylist> {
		SCPaging(client: client.path("library", "all"), limit: limit)
	}

	func whoToFollow(limit: Int? = nil) -> SCPaging<SCO.Recommendation> {
		SCPaging(client: client.path("suggested", "users", "who_to_follow"), limit: limit)
	}

	func history(limit: Int? = nil) -> SCPaging<SCO.HistoryItem> {
		SCPaging(client: client.path("play-history", "tracks"), limit: limit)
	}

	func addToHistory(urn: String) async throws {
		try await client.path("play-history").body(["track_urn": urn]).post()
	}

	func repostTrack(id: String) async throws {
		try await client.path("track_reposts", id).put()
	}

	func unrepostTrack(id: String) async throws {
		try await client.path("track_reposts", id).delete()
	}

	func repostPlaylist(id: String) async throws {
		try await client.path("playlist_reposts", id).put()
	}

	func unrepostPlaylist(id: String) async throws {
		try await client.path("playlist_reposts", id).delete()
	}
}

public extension SoundCloud.API {

	func stream(limit: Int? = nil) -> SCPaging<SCO.Post> {
		SCPaging(client: client.path("stream"), limit: limit)
	}

	func userStream(_ id: String, limit: Int? = nil) -> SCPaging<SCO.Post> {
		SCPaging(client: client.path("stream", "users", id), limit: limit)
	}

	func tracks(_ ids: [Int], limit: Int? = nil) -> SCPaging<SCO.Track> {
		SCPaging(client: client("tracks"), query: ("ids", ids), limit: limit)
	}

	func trackComments(
		_ id: String,
		threaded: Bool = true,
		filterReplies: Bool = false,
		limit: Int? = nil
	) -> SCPaging<SCO.Comment> {
		SCPaging(
			client: client("tracks", id, "comments")
				.query("client_id", clientID)
				.query("threaded", threaded ? 1 : 0)
				.query("filter_replies", filterReplies ? 1 : 0),
			limit: limit
		)
	}

	func playlist(id: String) async throws -> SCO.Playlist {
		try await client("playlists", id).get()
	}

	func systemPlaylist(_ urn: String) async throws -> SCO.Playlist {
		try await client("system-playlists", urn).get()
	}

	func resolve(_ url: URL) async throws -> SCO.Some? {
		try await client.query("url", url.absoluteString).get()
	}

	func addTracksToPlaylist(id: String, trackIDs: [Int]) async throws -> SCO.Playlist {
		try await client("playlists", id).query("client_id", clientID).body(["playlist": EditPlaylist(tracks: trackIDs)]).put()
	}

	func trackStation(id: String) async throws -> SCO.Playlist {
		try await client("system-playlists", "soundcloud:system-playlists:track-stations:\(id)").get()
	}

	func artistStation(id: String) async throws -> SCO.Playlist {
		try await client("system-playlists", "soundcloud:system-playlists:artist-stations:\(id)").get()
	}

	func createPlaylist(title: String, description: String? = nil, trackIDs: [Int]? = nil) async throws -> SCO.Playlist {
		try await client("playlists")
			.body(["playlist": EditPlaylist(title: title, description: description, tracks: trackIDs)])
			.post()
	}

	func streamURL(url: URL) async throws -> URL {
		try await client.url(url).call(.http, as: .decodable(FileURL.self)).url
	}

	func waveform(url: URL) async throws -> SCO.Waveform {
		try await client.url(url).get()
	}
}

public extension SoundCloud.API {

	func user(_ id: String) -> User { User(client: client("users", id)) }
	struct User { let client: APIClient }
}

public extension SoundCloud.API.User {

	func get() async throws -> SCO.User? { try await client.get() }

	func followings(limit: Int? = nil) -> SCPaging<SCO.User> {
		SCPaging(client: client.path("followings"), limit: limit)
	}

	func followers(limit: Int? = nil) -> SCPaging<SCO.User> {
		SCPaging(client: client.path("followers"), limit: limit)
	}

	func trackLikes(limit: Int? = nil) -> SCPaging<SCO.TrackLike> {
		SCPaging(client: client.path("track_likes"), limit: limit)
	}

	func likeTrack(id: String) async throws {
		try await client.path("track_likes", id).put()
	}

	func unlikeTrack(id: String) async throws {
		try await client.path("track_likes", id).delete()
	}

	func likePlaylist(id: String) async throws {
		try await client.path("playlist_likes", id).put()
	}

	func unlikePlaylist(id: String) async throws {
		try await client.path("playlist_likes", id).delete()
	}
}

public extension SoundCloud.API {

	func search(_ query: String, auth: Bool = true, limit: Int? = nil) -> SCPaging<SCO.Some> {
		SCPaging(client: search.client.auth(enabled: auth).query("q", query).query("limit", limit), limit: limit)
	}

	var search: Search { Search(client: client("search").query("client_id", clientID)) }
	struct Search { let client: APIClient }
}

public extension SoundCloud.API.Search {

	func tracks(_ query: String, auth: Bool = true, limit: Int? = nil) -> SCPaging<SCO.Track> {
		SCPaging(client: client("tracks").auth(enabled: auth).query("q", query).query("limit", limit), limit: limit)
	}

	func users(_ query: String, auth: Bool = true, limit: Int? = nil) -> SCPaging<SCO.User> {
		SCPaging(client: client("users").auth(enabled: auth).query("q", query).query("limit", limit), limit: limit)
	}

	func albums(_ query: String, auth: Bool = true, limit: Int? = nil) -> SCPaging<SCO.Playlist> {
		SCPaging(client: client("albums").auth(enabled: auth).query("q", query).query("limit", limit), limit: limit)
	}

	func playlists(_ query: String, auth: Bool = true, limit: Int? = nil) -> SCPaging<SCO.Playlist> {
		SCPaging(client: client("playlists").auth(enabled: auth).query("q", query).query("limit", limit), limit: limit)
	}
}

private struct EditPlaylist: Equatable, Codable {

	var title: String?
	var description: String?
	var tracks: [Int]?

	init(title: String? = nil, description: String? = nil, tracks: [Int]? = nil) {
		self.title = title
		self.description = description
		self.tracks = tracks // ?.map { Track(id: "\($0)") }
	}

	struct Track: Codable, Equatable, Identifiable {
		var id: String
	}
}

private struct FileURL: Codable {

	var url: URL
}
