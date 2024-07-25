import Foundation
import SwiftAPIClient
import SwiftMusicServicesApi

extension SoundCloud.API {
    
    public func me() async throws -> SoundCloud.Objects.User { try await client.path("me").get() }
    public var me: Me { Me(client: client("me")) }
    
    public struct Me { let client: APIClient }
}

extension SoundCloud.API.Me {
    
    public func library(limit: Int? = nil) -> SCPaging<SCO.LibraryPlaylist> {
        SCPaging(client: client.path("library", "all"), limit: limit)
    }
    
    public func whoToFollow(limit: Int? = nil) -> SCPaging<SCO.Recommendation> {
        SCPaging(client: client.path("suggested", "users", "who_to_follow"), limit: limit)
    }

    public func history(limit: Int? = nil) -> SCPaging<SCO.HistoryItem> {
        SCPaging(client: client.path("play-history", "tracks"), limit: limit)
    }

    public func addToHistory(urn: String) async throws {
        try await client.path("play-history").body(["track_urn": urn]).post()
    }
    
    public func repostTrack(id: String) async throws {
        try await client.path("track_reposts", id).put()
    }

    public func unrepostTrack(id: String) async throws {
        try await client.path("track_reposts", id).delete()
    }
    
    public func repostPlaylist(id: String) async throws {
        try await client.path("playlist_reposts", id).put()
    }
    
    public func unrepostPlaylist(id: String) async throws {
        try await client.path("playlist_reposts", id).delete()
    }
}

extension SoundCloud.API {
    
    public func stream(limit: Int? = nil) -> SCPaging<SCO.Post> {
        SCPaging(client: client.path("stream"), limit: limit)
    }

    public func userStream(_ id: String, limit: Int? = nil) -> SCPaging<SCO.Post> {
        SCPaging(client: client.path("stream", "users", id), limit: limit)
    }

    public func tracks(_ ids: [Int], limit: Int? = nil) -> SCPaging<SCO.Track> {
        SCPaging(client: client("tracks"), query: ("ids", ids), limit: limit)
    }

    public func trackComments(
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

    public func playlist(id: String) async throws -> SCO.Playlist {
        try await client("playlists", id).get()
    }
    
    public func systemPlaylist(_ urn: String) async throws -> SCO.Playlist {
        try await client("system-playlists", urn).get()
    }

    public func resolve(_ url: URL) async throws -> SCO.Some? {
        try await client.query("url", url.absoluteString).get()
    }

    public func addTracksToPlaylist(id: String, trackIDs: [Int]) async throws -> SCO.Playlist {
        try await client("playlists", id).body(["playlist": EditPlaylist(tracks: trackIDs)]).put()
    }
    
    public func trackStation(id: String) async throws -> SCO.Playlist {
        try await client("system-playlists", "soundcloud:system-playlists:track-stations:\(id)").get()
    }
    
    public func artistStation(id: String) async throws -> SCO.Playlist {
        try await client("system-playlists", "soundcloud:system-playlists:artist-stations:\(id)").get()
    }

    public func createPlaylist(title: String, description: String? = nil, trackIDs: [Int]? = nil) async throws -> SCO.Playlist {
        try await client("playlists")
            .body(["playlist": EditPlaylist(title: title, description: description, tracks: trackIDs)])
            .post()
    }

    public func streamURL(url: URL) async throws -> URL {
        try await client.url(url).call(.http, as: .decodable(FileURL.self)).url
    }

    public func waveform(url: URL) async throws -> SCO.Waveform {
        try await client.url(url).get()
    }
}

extension SoundCloud.API {
    
    public func user(_ id: String) -> User { User(client: client("users", id)) }
    public struct User { let client: APIClient }
}

extension SoundCloud.API.User {

    public func get() async throws -> SCO.User? { try await client.get() }
    
    public func followings(limit: Int? = nil) -> SCPaging<SCO.User> {
        SCPaging(client: client.path("followings"), limit: limit)
    }

    public func followers(limit: Int? = nil) -> SCPaging<SCO.User> {
        SCPaging(client: client.path("followers"), limit: limit)
    }

    public func trackLikes(limit: Int? = nil) -> SCPaging<SCO.TrackLike> {
        SCPaging(client: client.path("track_likes"), limit: limit)
    }

    public func likeTrack(id: String) async throws {
        try await client.path("track_likes", id).put()
    }

    public func unlikeTrack(id: String) async throws {
        try await client.path("track_likes", id).delete()
    }
    
    public func likePlaylist(id: String) async throws {
        try await client.path("playlist_likes", id).put()
    }
    
    public func unlikePlaylist(id: String) async throws {
        try await client.path("playlist_likes", id).delete()
    }
}

extension SoundCloud.API {

    public func search(_ query: String, limit: Int? = nil) -> SCPaging<SCO.Some> {
        SCPaging(client: search.client.query("q", query), limit: limit)
    }

    public var search: Search { Search(client: client("search")) }
    public struct Search { let client: APIClient }
}

extension SoundCloud.API.Search {

    public func tracks(_ query: String, limit: Int? = nil) -> SCPaging<SCO.Track> {
        SCPaging(client: client("tracks").query("q", query), limit: limit)
    }
    
    public func users(_ query: String, limit: Int? = nil) -> SCPaging<SCO.User> {
        SCPaging(client: client("users").query("q", query), limit: limit)
    }
    
    public func albums(_ query: String, limit: Int? = nil) -> SCPaging<SCO.Playlist> {
        SCPaging(client: client("albums").query("q", query), limit: limit)
    }

    public func playlists(_ query: String, limit: Int? = nil) -> SCPaging<SCO.Playlist> {
        SCPaging(client: client("playlists").query("q", query), limit: limit)
    }
}

private struct EditPlaylist: Equatable, Codable {
    
    var title: String?
    var description: String?
    var tracks: [Int]?
}

private struct FileURL: Codable {

    var url: URL
}
