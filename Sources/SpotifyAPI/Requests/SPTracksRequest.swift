import Foundation
import SwiftHttp

public extension Spotify.API {

	func tracks(ids: [String], market: String? = nil) async throws -> [SPTrack] {
		let output: TracksOutput = try await decodableRequest(
			executor: dataTask,
			url: v1BaseURL.path("tracks").query(from: TracksInput(ids: ids, market: market)),
			method: .get,
			headers: headers()
		)
		return output.tracks
	}

	struct TracksInput: Encodable {
		public var ids: [String]
		public var market: String?

		public init(ids: [String], market: String? = nil) {
			self.ids = ids
			self.market = market
		}
	}

	struct TracksOutput: Codable {
		public var tracks: [SPTrack]
	}

	func myTracks(limit: Int? = nil, offset: Int? = nil, market: String? = nil) throws -> AsyncThrowingStream<[SPSavedTrack], Error> {
		try pagingRequest(
			output: SPPaging<SPSavedTrack>.self,
			executor: dataTask,
			url: v1BaseURL.path("me", "tracks").query(from: SavedInput(limit: limit ?? 50, offset: offset, market: market)),
			method: .get,
			parameters: (),
			headers: headers(),
            limit: limit
		)
	}

	struct SavedInput: Encodable {
		public var limit: Int?
		public var offset: Int?
		public var market: String?
	}
}
