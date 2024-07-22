import Foundation
import SwiftMusicServicesApi
import SwiftAPIClient

public extension Tidal.API.V1 {
    
    var users: Users {
        Users(client: client("users"))
    }

    struct Users {
        
        public let client: APIClient

        public func callAsFunction(_ id: String) -> Tidal.API.V1.User {
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
    
    var favorites: Favorites {
        Favorites(client: client("favorites"))
    }
    
    struct Favorites {
        
        public let client: APIClient
    }
    
    var playlists: Playlists {
        Playlists(client: client("playlists"))
    }
    
    struct Playlists {
        
        public let client: APIClient
    }
}

public extension Tidal.API.V1.User.Favorites {

    func tracks(
        order: Tidal.Objects.Order? = nil,
        orderDirection: Tidal.Objects.OrderDirection? = nil,
        limit: Int? = nil,
        offset: Int = 0
    ) -> TidalPaging<Tidal.Objects.UserTrack> {
        TidalPaging(
            client: client("tracks")
                .query(["order": order, "orderDirection": orderDirection]),
            limit: limit,
            offset: offset
        )
    }
}

public extension Tidal.API.V1.User.Playlists {

    func create(
        title: String,
        description: String? = nil
    ) async throws -> Tidal.Objects.Playlist {
        try await client
            .body(["title": title, "description": description])
            .post()
    }
}

extension Tidal.Objects {
    
    public enum Order: String, Codable {

        case date = "DATE"
        case name = "NAME"
        case artist = "ARTIST"
        case releaseDate = "RELEASE_DATE"
    }
    
    public enum OrderDirection: String, Codable {

        case ascending = "ASC"
        case descending = "DESC"
    }
}
