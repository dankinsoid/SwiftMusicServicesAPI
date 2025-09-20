import Foundation
import SwiftAPIClient
import SwiftMusicServicesApi

public extension Spotify.API {

	/// Get Spotify catalog information for multiple tracks based on their Spotify IDs.
	/// - Parameters:
	///   - ids: A list of the Spotify IDs for the tracks. Maximum: 50 IDs.
	///   - market: An ISO 3166-1 alpha-2 country code. If a country code is specified, only content that is available in that market will be returned.
	///   If a valid user access token is specified in the request header, the country associated with the user account will take priority over this parameter.
	func tracks(ids: [String], market: CountryCode? = nil) async throws -> [SPTrack] {
		try await client("tracks")
			.query(TracksInput(ids: ids, market: market))
			.call(.http, as: .decodable(TracksOutput.self))
			.tracks
	}

	struct TracksInput: Encodable {
		public var ids: [String]
		public var market: CountryCode?

		public init(ids: [String], market: CountryCode? = nil) {
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

	func myTracks(limit: Int? = nil, offset: Int? = nil, market: CountryCode? = nil) -> Spotify.API.Paging<SPPaging<SPSavedTrack>> {
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
	
	func myAlbums(limit: Int? = nil, offset: Int? = nil, market: CountryCode? = nil) -> Spotify.API.Paging<SPPaging<SPSavedAlbum>> {
		pagingRequest(
			of: SPPaging<SPSavedAlbum>.self,
			parameters: (),
			limit: limit
		) { [client] in
			try await client.path("me", "albums")
				.query(SavedInput(limit: limit ?? 50, offset: offset, market: market))
				.get()
		}
	}
	
	struct SavedInput: Codable, Sendable, Equatable {
		public var limit: Int?
		public var offset: Int?
		public var market: CountryCode?
		
		public init(limit: Int? = nil, offset: Int? = nil, market: CountryCode? = nil) {
			self.limit = limit
			self.offset = offset
			self.market = market
		}
	}
	
	/// Get the artists followed by the current user.
	/// - Parameter type: The ID type. Currently, the only type that is supported is `artist`.
	/// - Parameter limit: The maximum number of items to return. Default is 50. Minimum is 1, maximum is 50.
	func followed(
		_ type: FollowingType,
		limit: Int? = nil
	) async throws -> Spotify.API.Paging<SPPaging<SPArtist>> {
		pagingRequest(
			of: SPPaging<SPArtist>.self,
			parameters: (),
			limit: limit
		) { [client] in
			try await client.path("me", "following")
				.query(FollowingInput(type: type, limit: limit ?? 50))
				.get()
		}
	}
	
	/// Add the current user as a follower of one or more artists or other Spotify users.
	/// - Parameters:
	///  - type: The ID type. Currently, the only type that is supported is `artist` or `user`.
	///  - ids: A list of the Spotify IDs for the artists or users to be followed. Maximum: 50 IDs.
	func follow(_ type: FollowingType, ids: [String]) async throws {
		try await client.path("me", "following")
			.query("type", type.rawValue)
			.body(["ids": ids])
			.put()
	}
	
	/// Remove the current user as a follower of one or more artists or other Spotify users.
	/// - Parameters:
	/// - type: The ID type. Currently, the only type that is supported is `artist` or `user`.
	/// - ids: A list of the Spotify IDs for the artists or users to be unfollowed. Maximum: 50 IDs.
	func unfollow(_ type: FollowingType, ids: [String]) async throws {
		try await client.path("me", "following")
			.query("type", type.rawValue)
			.body(["ids": ids])
			.delete()
	}

	struct FollowingType: RawRepresentable, Codable, Hashable, Sendable {
		public var rawValue: String
		
		public init(rawValue: String) {
			self.rawValue = rawValue
		}
		
		public static let artist = FollowingType(rawValue: "artist")
		public static let user = FollowingType(rawValue: "user")
	}
	
	struct FollowingInput: Codable, Sendable {
		
		public var type: FollowingType
		public var limit: Int?
		public var after: String?
		
		public init(type: FollowingType, limit: Int? = nil, after: String? = nil) {
			self.type = type
			self.limit = limit
			self.after = after
		}
	}
	
	/// Save one or more albums to the current user's "Your Music" library.
	/// - Parameter ids: A list of the Spotify IDs for the albums to be saved. Maximum: 50 IDs.
	func save(albums ids: [String]) async throws {
		try await client.path("me", "albums")
			.body(["ids": ids])
			.put()
	}
	
	/// Save one or more tracks to the current user's "Your Music" library.
	/// - Parameter ids: A list of the Spotify IDs for the tracks to be saved. Maximum: 50 IDs.
	func save(tracks ids: [SPTimestampedID]) async throws {
		try await client.path("me", "tracks")
			.body(["timestamped_ids": ids])
			.put()
	}
}

public struct SPTimestampedID: Codable, Hashable, Sendable {
	
	public var id: String
	public var addedAt: Date?
	
	public init(id: String, addedAt: Date? = nil) {
		self.id = id
		self.addedAt = addedAt
	}
}
