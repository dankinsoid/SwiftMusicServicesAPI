
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Search {

	/**
	 Performs a track search based on a query

	 **GET** /tracks
	 */
	func getTracks(q: String? = nil, ids: String? = nil, genres: String? = nil, tags: String? = nil, bpm: Bpm? = nil, duration: Duration? = nil, createdAt: CreatedAt? = nil, access: [Access]? = nil, limit: Int? = nil, offset: Int? = nil, linkedPartitioning: Bool? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> Status200 {
		try await client
			.path("/tracks")
			.method(.get)
			.query([
				"q": q,
				"ids": ids,
				"genres": genres,
				"tags": tags,
				"bpm": bpm,
				"duration": duration,
				"created_at": createdAt,
				"access": access,
				"limit": limit,
				"offset": offset,
				"linked_partitioning": linkedPartitioning,
			])
			.auth(enabled: true)
			.call(
				.http,
				as: .decodable,
				fileID: fileID,
				line: line
			)
	}

	enum GetTracks {

		public struct Bpm: Codable, Equatable {

			/** Return tracks with at least this bpm value */
			public var from: Int?
			/** Return tracks with at most this bpm value */
			public var to: Int?

			public enum CodingKeys: String, CodingKey {

				case from
				case to
			}

			public init(
				from: Int? = nil,
				to: Int? = nil
			) {
				self.from = from
				self.to = to
			}
		}

		public struct Duration: Codable, Equatable {

			/** Return tracks with at least this duration value */
			public var from: Int?
			/** Return tracks with at most this duration value */
			public var to: Int?

			public enum CodingKeys: String, CodingKey {

				case from
				case to
			}

			public init(
				from: Int? = nil,
				to: Int? = nil
			) {
				self.from = from
				self.to = to
			}
		}

		public struct CreatedAt: Codable, Equatable {

			/** (yyyy-mm-dd hh:mm:ss) return tracks created at this date or later */
			public var from: String?
			/** (yyyy-mm-dd hh:mm:ss) return tracks created at this date or earlier */
			public var to: String?

			public enum CodingKeys: String, CodingKey {

				case from
				case to
			}

			public init(
				from: String? = nil,
				to: String? = nil
			) {
				self.from = from
				self.to = to
			}
		}
	}
}
