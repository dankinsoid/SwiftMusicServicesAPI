import Foundation
import SwiftAPIClient
import SwiftMusicServicesApi

public extension Spotify.API {

	func tracks(ids: [String], market: String? = nil) async throws -> [SPTrack] {
		try await client("tracks")
            .query(TracksInput(ids: ids, market: market))
            .call(.http, as: .decodable(TracksOutput.self))
            .tracks
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
		@SafeDecodeArray public var tracks: [SPTrack]
		
		public init(tracks: [SPTrack]) {
			_tracks = SafeDecodeArray(tracks)
		}
	}

	func myTracks(limit: Int? = nil, offset: Int? = nil, market: String? = nil) -> Spotify.API.Paging<SPPaging<SPSavedTrack>> {
		pagingRequest(
			of: SPPaging<SPSavedTrack>.self,
			parameters: (),
			limit: limit
		) { [client] in
			try await client.path("me", "tracks")
				.query(SavedInput(limit: limit ?? 50, offset: offset, market: market))
				.get()
		}
	}

	struct SavedInput: Encodable {
		public var limit: Int?
		public var offset: Int?
		public var market: String?
	}
}
