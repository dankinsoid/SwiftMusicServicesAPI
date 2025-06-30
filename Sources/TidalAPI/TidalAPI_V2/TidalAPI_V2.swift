// swiftlint:disable all
import Foundation
import SwiftAPIClient

/** TIDAL API is a [JSON:API](https://jsonapi.org/) Web API that gives access to TIDAL functionality and data. */
public struct TidalAPI_V2 {

	public static let version = "0.1.21"
	public var client: APIClient

	public init(client: APIClient) {
		self.client = client
	}
}

public extension TidalAPI_V2 {

	struct Server: Hashable {

		/// URL of the server
		public var url: URL

		public init(_ url: URL) {
			self.url = url
		}

		public static var `default` = TidalAPI_V2.Server.main

		/** Production */
		public static let main = TidalAPI_V2.Server(URL(string: "https://openapi.tidal.com/v2")!)
	}
}

public extension APIClient.Configs {

	/// TidalAPI_V2 server
	var tidalAPI_V2Server: TidalAPI_V2.Server {
		get { self[\.tidalAPI_V2Server] ?? .default }
		set { self[\.tidalAPI_V2Server] = newValue }
	}
}

public extension TidalAPI_V2 {
	var albums: Albums { Albums(client: client) }
	struct Albums { var client: APIClient }
}

public extension TidalAPI_V2 {
	var artistRoles: ArtistRoles { ArtistRoles(client: client) }
	struct ArtistRoles { var client: APIClient }
}

public extension TidalAPI_V2 {
	var artists: Artists { Artists(client: client) }
	struct Artists { var client: APIClient }
}

public extension TidalAPI_V2 {
	var artworks: Artworks { Artworks(client: client) }
	struct Artworks { var client: APIClient }
}

public extension TidalAPI_V2 {
	var playlists: Playlists { Playlists(client: client) }
	struct Playlists { var client: APIClient }
}

public extension TidalAPI_V2 {
	var providers: Providers { Providers(client: client) }
	struct Providers { var client: APIClient }
}

public extension TidalAPI_V2 {
	var searchResults: SearchResults { SearchResults(client: client) }
	struct SearchResults { var client: APIClient }
}

public extension TidalAPI_V2 {
	var searchSuggestions: SearchSuggestions { SearchSuggestions(client: client) }
	struct SearchSuggestions { var client: APIClient }
}

public extension TidalAPI_V2 {
	var trackFiles: TrackFiles { TrackFiles(client: client) }
	struct TrackFiles { var client: APIClient }
}

public extension TidalAPI_V2 {
	var trackManifests: TrackManifests { TrackManifests(client: client) }
	struct TrackManifests { var client: APIClient }
}

public extension TidalAPI_V2 {
	var tracks: Tracks { Tracks(client: client) }
	struct Tracks { var client: APIClient }
}

public extension TidalAPI_V2 {
	var userCollections: UserCollections { UserCollections(client: client) }
	struct UserCollections { var client: APIClient }
}

public extension TidalAPI_V2 {
	var userEntitlements: UserEntitlements { UserEntitlements(client: client) }
	struct UserEntitlements { var client: APIClient }
}

public extension TidalAPI_V2 {
	var userRecommendations: UserRecommendations { UserRecommendations(client: client) }
	struct UserRecommendations { var client: APIClient }
}

public extension TidalAPI_V2 {
	var userReports: UserReports { UserReports(client: client) }
	struct UserReports { var client: APIClient }
}

public extension TidalAPI_V2 {
	var users: Users { Users(client: client) }
	struct Users { var client: APIClient }
}

public extension TidalAPI_V2 {
	var videos: Videos { Videos(client: client) }
	struct Videos { var client: APIClient }
}
