import Foundation

public extension AppleMusic.API {

    /// [Documentation](https://developer.apple.com/documentation/applemusicapi/search_for_catalog_resources)
    ///
    /// Search the catalog by using a query.
    ///
    /// - Parameters:
    ///   - storefront: An iTunes Store territory, specified by an ISO 3166 alpha-2 country code. The possible values are the id attributes of Storefront objects.
    ///   - query: The entered text for the search with ‘+’ characters between each word, to replace spaces (for example term=james+br).
    ///   - t: The list of the types of resources to include in the results.
    ///   Possible Values: activities, albums, apple-curators, artists, curators, music-videos, playlists, record-labels, songs, stations
    ///   - limit: The number of objects or number of objects in the specified relationship returned. Default is 5, maximum is 25.
	func search(
        storefront: String,
        query: String,
        types: [AppleMusic.Types] = [.songs],
        limit: Int = 5
    ) async throws -> [AppleMusic.Objects.Item] {
		try await search(
            storefront: storefront,
            input: SearchInput(
                term: query.replacingOccurrences(of: " ", with: "+"),
                limit: limit,
                types: types
            )
        )
	}

	func search(storefront: String, input: SearchInput) async throws -> [AppleMusic.Objects.Item] {
        try await client
            .path("v1", "catalog", storefront, "search")
            .query(input)
            .call(.http, as: .decodable(SearchResults.self))
            .results.songs?.data ?? []
	}

	struct SearchInput: Encodable {

		public var term: String
		public var limit = 5
		public var offset = 0
		public var types: [AppleMusic.Types]
	}

	struct SearchResults: Decodable {
		public var results: Songs

		public struct Songs: Decodable {
			public var songs: AppleMusic.Objects.Response<AppleMusic.Objects.Item>?
            
            public init(songs: AppleMusic.Objects.Response<AppleMusic.Objects.Item>? = nil) {
                self.songs = songs
            }
		}
	}
}
