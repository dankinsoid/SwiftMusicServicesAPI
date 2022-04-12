//
//  AppleMusicSearch.swift
//  MusicImport
//
//  Created by Daniil on 27.10.2020.
//  Copyright © 2020 Данил Войдилов. All rights reserved.
//

import Foundation
import SwiftHttp
import VDCodable

extension AppleMusic.API {

	public func search(storefront: String, query: String, types: [AppleMusic.Types] = [.songs], limit: Int = 20) async throws -> [AppleMusic.Objects.Item] {
		try await search(storefront: storefront, input: SearchInput(term: query.replacingOccurrences(of: " ", with: "+"), limit: limit, types: types))
	}

	public func search(storefront: String, input: SearchInput) async throws -> [AppleMusic.Objects.Item] {
		let results: SearchResults = try await decodableRequest(
				executor: client.dataTask,
				url: baseURL.path("catalog", storefront, "search").query(from: input),
				method: .get,
				headers: headers()
		)
		return (results.results.songs?.map({ $0.data }).joined()).map { Array($0) } ?? []
	}

	public struct SearchInput: Encodable {
		public var term: String
		public var limit: Int = 15
		public var offset: Int = 0
		public var types: [AppleMusic.Types]
	}

	public struct SearchResults: Decodable {
		public var results: Songs

		public struct Songs: Decodable {
			public var songs: [AppleMusic.Objects.Response<AppleMusic.Objects.Item>]?
		}
	}
}
