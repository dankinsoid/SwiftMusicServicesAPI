import Foundation
import SwiftMusicServicesApi
import SwiftAPIClient

public extension Tidal.API.V1 {
    
    var tracks: Tracks {
        Tracks(client: client("tracks"))
    }
    
    struct Tracks {
        
        public let client: APIClient
    }
}

public extension Tidal.API.V1.Tracks {
    
    func isrc(
        _ isrc: String,
        auth: Bool = true,
        limit: Int? = nil
    ) async throws -> [Tidal.Objects.Track] {
        try await TidalPaging<Tidal.Objects.Track>(client: client.query("isrc", isrc), limit: limit, offset: 0)
            .first()
            .items
    }
}
