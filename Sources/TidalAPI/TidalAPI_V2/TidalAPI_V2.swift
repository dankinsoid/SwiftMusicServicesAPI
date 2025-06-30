// swiftlint:disable all
import Foundation
import SwiftAPIClient

/** TIDAL API is a [JSON:API](https://jsonapi.org/) Web API that gives access to TIDAL functionality and data. */
public extension Tidal.API {

	struct V2 {

		public static let baseURL = URL(string: "https://openapi.tidal.com/v2")!
		public static let version = "0.1.21"

		public var client: APIClient
		public let cache: SecureCacheService

		public init(
			client: APIClient = APIClient(),
			clientID: String,
			clientSecret: String,
			redirectURI: String,
			defaultCountryCode: String = "US",
			cache: SecureCacheService
		) {
			self.client = client
				.url(Self.baseURL)
				.tokenRefresher(cacheService: cache) { _, _, _ in
					let token = try await Auth(client: client, clientID: clientID, clientSecret: clientSecret, redirectURI: redirectURI)
						.refreshToken(cache: cache)
					return (token.accessToken, token.refreshToken, token.expiresAt)
				} auth: {
					.bearer(token: $0)
				}
				.httpClientMiddleware(CountryCodeRequestMiddleware(cache: cache, defaultCountryCode: defaultCountryCode))
				.auth(enabled: true)
				.bodyDecoder(.json(dateDecodingStrategy: .tidal, dataDecodingStrategy: .base64))
				.errorDecoder(.decodable(TDO.ErrorDocument.self))
				.bodyEncoder(.json(dataEncodingStrategy: .base64))
				.finalizeRequest { request, _ in
					if request.headers[.authorization] == nil, let name = HTTPField.Name("x-tidal-token") {
						request.headers[name] = clientID
					}
				}
				.httpResponseValidator(.statusCode)
			self.cache = cache
		}
	}
}

public extension Tidal.API.V2 {
	var albums: Albums { Albums(client: client) }
	struct Albums { var client: APIClient }
}

public extension Tidal.API.V2 {
	var artistRoles: ArtistRoles { ArtistRoles(client: client) }
	struct ArtistRoles { var client: APIClient }
}

public extension Tidal.API.V2 {
	var artists: Artists { Artists(client: client) }
	struct Artists { var client: APIClient }
}

public extension Tidal.API.V2 {
	var artworks: Artworks { Artworks(client: client) }
	struct Artworks { var client: APIClient }
}

public extension Tidal.API.V2 {
	var playlists: Playlists { Playlists(client: client) }
	struct Playlists { var client: APIClient }
}

public extension Tidal.API.V2 {
	var providers: Providers { Providers(client: client) }
	struct Providers { var client: APIClient }
}

public extension Tidal.API.V2 {
	var searchResults: SearchResults { SearchResults(client: client) }
	struct SearchResults { var client: APIClient }
}

public extension Tidal.API.V2 {
	var searchSuggestions: SearchSuggestions { SearchSuggestions(client: client) }
	struct SearchSuggestions { var client: APIClient }
}

public extension Tidal.API.V2 {
	var trackFiles: TrackFiles { TrackFiles(client: client) }
	struct TrackFiles { var client: APIClient }
}

public extension Tidal.API.V2 {
	var trackManifests: TrackManifests { TrackManifests(client: client) }
	struct TrackManifests { var client: APIClient }
}

public extension Tidal.API.V2 {
	var tracks: Tracks { Tracks(client: client) }
	struct Tracks { var client: APIClient }
}

public extension Tidal.API.V2 {
	var userCollections: UserCollections { UserCollections(client: client) }
	struct UserCollections { var client: APIClient }
}

public extension Tidal.API.V2 {
	var userEntitlements: UserEntitlements { UserEntitlements(client: client) }
	struct UserEntitlements { var client: APIClient }
}

public extension Tidal.API.V2 {
	var userRecommendations: UserRecommendations { UserRecommendations(client: client) }
	struct UserRecommendations { var client: APIClient }
}

public extension Tidal.API.V2 {
	var userReports: UserReports { UserReports(client: client) }
	struct UserReports { var client: APIClient }
}

public extension Tidal.API.V2 {
	var users: Users { Users(client: client) }
	struct Users { var client: APIClient }
}

public extension Tidal.API.V2 {
	var videos: Videos { Videos(client: client) }
	struct Videos { var client: APIClient }
}
