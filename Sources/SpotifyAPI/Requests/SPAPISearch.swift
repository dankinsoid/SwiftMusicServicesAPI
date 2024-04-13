import Foundation
import SwiftAPIClient

public extension Spotify.API {

	/// https://developer.spotify.com/documentation/web-api/reference/search
	func search(
		q: SPQuery,
		type: [SPContentType],
		market: String? = nil,
		limit: Int? = nil,
		offset: Int? = nil,
		includeExternal: SearchInput.External? = nil
	) async throws -> SearchOutput {
        try await client("search")
            .query(
                SearchInput(q: q, type: type, market: market, limit: limit, offset: offset, includeExternal: includeExternal)
            )
            .get()
	}

	func searchQuery(
		q: SPQuery,
		type: SPContentType,
		market: String? = nil,
		limit: Int? = nil,
		offset: Int? = nil,
		includeExternal: SearchInput.External? = nil
	) -> AsyncThrowingStream<[SearchOutput], Error> {
        pagingRequest(
			of: SearchOutput.self,
			parameters: type
        ) { [client] in
            try await client("search")
                .query(
                    SearchInput(q: q, type: [type], market: market, limit: limit, offset: offset, includeExternal: includeExternal)
                ).get()
        }
	}

	struct SearchInput: Encodable {

		public var q: SPQuery
		public var type: [SPContentType]
		public var market: String?
		public var limit: Int?
		public var offset: Int?
		public var includeExternal: External?

		public enum External: String, Codable, CaseIterable {
			case audio, unknown

			public init(from decoder: Decoder) throws {
				self = try Self(rawValue: String(from: decoder)) ?? .unknown
			}
		}

		public init(
			q: SPQuery,
			type: [SPContentType],
			market: String? = nil,
			limit: Int? = nil,
			offset: Int? = nil,
			includeExternal: SearchInput.External? = nil
		) {
			self.q = q
			self.type = type
			self.market = market
			self.limit = limit
			self.offset = offset
			self.includeExternal = includeExternal
		}
	}

	struct SearchOutput: Decodable {

		public var artists: SPPaging<SPArtist>?
		public var albums: SPPaging<SPAlbumSimplified>?
		public var tracks: SPPaging<SPTrack>?
		public var shows: SPPaging<SPShow>?
		public var episodes: SPPaging<SPEpisodeSimplified>?
	}
}

// Добавить: NOT, OR
public struct SPQuery: Encodable {

	private var filters: [FieldFilters: String] = [:]
	private var text: String?

	public var value: String {
		var result = text ?? ""
		if !filters.isEmpty {
			if !result.isEmpty {
				result += " "
			}
			result += filters.map { "\($0.key.rawValue):\($0.value)" }.joined(separator: " ")
		}
		return result//.replacingOccurrences(of: " ", with: "%20")
	}
}

public extension SPQuery {

	subscript(_ key: FieldFilters) -> String? {
		get { filters[key] }
		set { filters[key] = newValue }
	}

	init(_ filters: [FieldFilters: String]) {
		self.filters = filters
	}

	init(_ value: String) {
		text = value
	}

	func encode(to encoder: Encoder) throws {
		try value.encode(to: encoder)
	}

	enum FieldFilters: String, Codable, Hashable, CaseIterable {

		case album, artist, track, year, genre, isrc, upc, unknown

		public init(from decoder: Decoder) throws {
			self = try Self(rawValue: String(from: decoder)) ?? .unknown
		}
	}
}

extension Spotify.API.SearchOutput: SpotifyPaging {

	public typealias Item = Spotify.API.SearchOutput

	public var items: [Spotify.API.SearchOutput] { [self] }

	public func nextURL(parameters: SPContentType) -> URL? {
		switch parameters {
		case .album: return albums?.nextURL()
		case .artist: return artists?.nextURL()
		case .playlist: return nil
		case .track: return tracks?.nextURL()
		case .show: return shows?.nextURL()
		case .episode: return episodes?.nextURL()
		case .unknown: return nil
		}
	}
}
