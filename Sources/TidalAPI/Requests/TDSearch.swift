import Foundation
import SwiftMusicServicesApi
import SwiftAPIClient

public extension Tidal.API.V1 {

    var search: Search {
        Search(client: client("search"))
    }

    struct Search {

        public let client: APIClient
    }
}

public extension Tidal.API.V1.Search {

    func tracks(
        query: String,
        auth: Bool = true,
        limit: Int? = nil
    ) -> TidalPaging<Tidal.Objects.Track> {
        TidalPaging(
            client: client("tracks").query("query", query).auth(enabled: auth),
            limit: limit,
            offset: 0
        )
    }
}
