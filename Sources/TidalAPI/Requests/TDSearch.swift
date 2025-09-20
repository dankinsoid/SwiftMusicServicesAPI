import Foundation
import SwiftAPIClient
import SwiftMusicServicesApi

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
	
	func artists(
		query: String,
		auth: Bool = true,
		limit: Int? = nil
	) -> TidalPaging<Tidal.Objects.Artist> {
		TidalPaging(
			client: client("artists").query("query", query).auth(enabled: auth),
			limit: limit,
			offset: 0
		)
	}
	
	func albums(
		query: String,
		auth: Bool = true,
		limit: Int? = nil
	) -> TidalPaging<Tidal.Objects.Album> {
		TidalPaging(
			client: client("albums").query("query", query).auth(enabled: auth),
			limit: limit,
			offset: 0
		)
	}
}
