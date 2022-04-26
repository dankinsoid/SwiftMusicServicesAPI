//
//  SPAPISearch.swift
//  MusicImport
//
//  Created by Daniil on 23.07.2020.
//  Copyright © 2020 Данил Войдилов. All rights reserved.
//

import Foundation
import SwiftHttp

extension Spotify.API {

	///https://developer.spotify.com/documentation/web-api/reference/search/search/
	public func search(
			q: SPQuery,
			type: [SPContentType],
			market: String? = nil,
			limit: Int? = nil,
			offset: Int? = nil,
			includeExternal: SearchInput.External? = nil
	) async throws -> SearchOutput {
		try await decodableRequest(
				executor: client.dataTask,
				url: baseURL.path("search").query(from: SearchInput(q: q, type: type, market: market, limit: limit, offset: offset, includeExternal: includeExternal)),
				method: .get,
				headers: headers()
		)
	}

	public func searchQuery(
			q: SPQuery,
			type: SPContentType,
			market: String? = nil,
			limit: Int? = nil,
			offset: Int? = nil,
			includeExternal: SearchInput.External? = nil
	) throws -> AsyncThrowingStream<[SearchOutput], Error> {
		try pagingRequest(
				output: SearchOutput.self,
				executor: client.dataTask,
				url: baseURL.path("search").query(from: SearchInput(q: q, type: [type], market: market, limit: limit, offset: offset, includeExternal: includeExternal)),
				method: .get,
				parameters: type,
				headers: headers()
		)
	}

	public struct SearchInput: Encodable {
		public var q: SPQuery
		public var type: [SPContentType]
		public var market: String?
		public var limit: Int?
		public var offset: Int?
		public var includeExternal: External?

		public enum External: String, Codable, CaseIterable {
			case audio
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

	public struct SearchOutput: Decodable {
		public var artists: SPPaging<SPArtist>?
		public var albums: SPPaging<SPAlbumSimplified>?
		public var tracks: SPPaging<SPTrack>?
		public var shows: SPPaging<SPShow>?
		public var episodes: SPPaging<SPEpisodeSimplified>?
	}
}

//Добавить: NOT, OR
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

extension SPQuery {
	public subscript(_ key: FieldFilters) -> String? {
		get { filters[key] }
		set { filters[key] = newValue }
	}
	
    public init(_ filters: [FieldFilters: String]) {
			self.filters = filters
    }
    
    public init(_ value: String) {
			text = value
    }
    
    public func encode(to encoder: Encoder) throws {
//        guard !(text ?? "").isEmpty || !(filters ?? [:]).isEmpty else {
//
//        }
			try value.encode(to: encoder)
    }
    
    public enum FieldFilters: String, Codable, Hashable, CaseIterable {
        case album, artist, track, year, genre, isrc, upc
    }
}

extension Spotify.API.SearchOutput: SpotifyPaging {
	public typealias Item = Spotify.API.SearchOutput

	public var items: [Spotify.API.SearchOutput] { [self] }

	public func nextURL(parameters: SPContentType) -> HttpUrl? {
		switch parameters {
		case .album:    return albums?.nextURL()
		case .artist:   return artists?.nextURL()
		case .playlist: return nil
		case .track:    return tracks?.nextURL()
		case .show:     return shows?.nextURL()
		case .episode:  return episodes?.nextURL()
		}
	}
}
