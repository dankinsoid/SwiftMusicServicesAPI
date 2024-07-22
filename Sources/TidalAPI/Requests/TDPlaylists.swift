import Foundation
import SwiftMusicServicesApi
import SwiftAPIClient

public extension Tidal.API.V1 {
    
    var playlists: Playlists {
        Playlists(client: client("playlists"))
    }

    struct Playlists {
        
        public let client: APIClient

        public func callAsFunction(_ id: String) -> Tidal.API.V1.Playlist {
            Tidal.API.V1.Playlist(client: client(id))
        }
    }
    
    struct Playlist {
        
        public let client: APIClient
    }
}

extension Tidal.API.V1.Playlist {

    func items(
        auth: Bool = true,
        limit: Int? = nil,
        offset: Int = 0
    ) -> TidalPaging<Tidal.Objects.UserTrack> {
        TidalPaging(
            client: client("items").auth(enabled: auth),
            limit: limit,
            offset: offset
        )
    }

    func add(
        trackIDs: [String],
        duplicationPolicy: Tidal.Objects.DuplicationPolicy = .skip,
        artifactNotFoundPolicy: Tidal.Objects.NotFoundPolicy = .skip
    ) async throws {
        try await client("items")
            .body([
                "itemIds": trackIDs,
                "onArtifactNotFound": artifactNotFoundPolicy,
                "onDupes": duplicationPolicy
            ])
            .post()
    }
}

extension Tidal.Objects {

    public enum DuplicationPolicy: String, Codable, Equatable {

        case fail = "FAIL"
        case skip = "SKIP"
        case replace = "REPLACE"
    }
    
    public enum NotFoundPolicy: String, Codable, Equatable {
        
        case fail = "FAIL"
        case skip = "SKIP"
    }
}
