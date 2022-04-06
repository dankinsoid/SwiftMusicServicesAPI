//
//  SPTracksRequest.swift
//  MusicImport
//
//  Created by Daniil on 27.10.2020.
//  Copyright © 2020 Данил Войдилов. All rights reserved.
//

import Foundation
import SwiftHttp

extension Spotify.API {
	
	public func tracks(ids: [String], market: String? = nil) async throws -> [SPTrack] {
		let output: TracksOutput = try await decodableRequest(
				executor: client.dataTask,
				url: baseURL.path("tracks").query(from: TracksInput(ids: ids, market: market)),
				method: .get,
				headers: headers()
		)
		return output.tracks
	}

	public struct TracksInput: Encodable {
		public var ids: [String]
		public var market: String?

		public init(ids: [String], market: String? = nil) {
			self.ids = ids
			self.market = market
		}
	}

	public struct TracksOutput: Codable {
		public var tracks: [SPTrack]
	}

	public func myTracks(limit: Int? = 50, offset: Int? = nil, market: String? = nil) throws -> AsyncThrowingStream<[SPSavedTrack], Error> {
		try pagingRequest(
				output: SPPaging<SPSavedTrack>.self,
				executor: client.dataTask,
				url: baseURL.path("me", "tracks").query(from: SavedInput(limit: limit, offset: offset, market: market)),
				method: .get,
				parameters: (),
				headers: headers()
		)
	}

	public struct SavedInput: Encodable {
		public var limit: Int? = 50
		public var offset: Int?
		public var market: String?
	}
}
