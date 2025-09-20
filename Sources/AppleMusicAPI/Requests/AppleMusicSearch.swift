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
		limit: Int = 5,
		language: String? = nil,
		modifications: [String]? = nil
	) async throws -> [AppleMusic.Objects.Item] {
		try await search(
			storefront: storefront,
			input: SearchInput(
				term: query.replacingOccurrences(of: " ", with: "+"),
				limit: limit,
				types: types,
				l: language,
				with: modifications
			)
		)
	}

	func search(storefront: String, input: SearchInput) async throws -> [AppleMusic.Objects.Item] {
		try await client
			.path("v1", "catalog", storefront, "search")
			.query(input)
			.call(.http, as: .decodable(SearchResults.self))
			.results[input.types]
	}

	func suggestions(
		storefront: String,
		types: [AppleMusic.Types]? = [.songs],
		query: String,
		language: String? = nil,
		limit: Int = 10
	) async throws -> [String] {
		try await client
			.path("v1", "catalog", storefront, "search", "suggestions")
			.query([
				"term": query.replacingOccurrences(of: " ", with: "+"),
				"limit": limit,
				"l": language,
				"types": types,
				"kinds": "topResults",
			])
			.call(.http, as: .decodable(SuggestionsResults.self))
			.results.suggestions?.compactMap(\.searchTerm) ?? []
	}

	struct SearchInput: Encodable {

		public var term: String
		public var limit = 5
		public var offset = 0
		public var types: [AppleMusic.Types]
		public var l: String?
		public var with: [String]?
	}

	struct SearchResults: Codable, Sendable {
		public var results: Results
		
		public init(results: Results) {
			self.results = results
		}

		public struct Results: Codable, Sendable {
			public var songs: AppleMusic.Objects.Response<AppleMusic.Objects.Item>?
			public var artists: AppleMusic.Objects.Response<AppleMusic.Objects.Item>?
			public var albums: AppleMusic.Objects.Response<AppleMusic.Objects.Item>?
			
			public subscript(type: AppleMusic.TrackType) -> AppleMusic.Objects.Response<AppleMusic.Objects.Item>? {
				switch type {
				case .songs: songs
				case .albums: albums
				case .artists: artists
				default: nil
				}
			}
			
			public subscript(types: [AppleMusic.Types]) -> [AppleMusic.Objects.Item] {
				var items: [AppleMusic.Objects.Item] = []
				for type in types {
					switch type {
					case .songs:
						if let songs {
							items.append(contentsOf: songs.data)
						}
					case .albums:
						if let albums {
							items.append(contentsOf: albums.data)
						}
					case .artists:
						if let artists {
							items.append(contentsOf: artists.data)
						}
					default:
						continue
					}
				}
				return items
			}

			public init(
				songs: AppleMusic.Objects.Response<AppleMusic.Objects.Item>? = nil,
				artists: AppleMusic.Objects.Response<AppleMusic.Objects.Item>? = nil,
				albums: AppleMusic.Objects.Response<AppleMusic.Objects.Item>? = nil
			) {
				self.songs = songs
				self.artists = artists
				self.albums = albums
			}
		}
	}

	struct SuggestionsResults: Codable {
		public var results: Results

		public struct Results: Codable {
			public var suggestions: [Suggestion]?

			public struct Suggestion: Codable {
				public var kind: String
				public var searchTerm: String?
				public var displayTerm: String?
			}
		}
	}
}
