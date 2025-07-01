import Foundation
import SwiftAPIClient
import SwiftMusicServicesApi

public extension TDO {

	struct PlaylistsAttributes: Codable, Equatable, Sendable {

		/** Access type */
		public var accessType: AccessType
		/** Indicates if the playlist has a duration and set number of tracks */
		public var bounded: Bool
		/** Datetime of playlist creation (ISO 8601) */
		public var createdAt: Date
		public var externalLinks: [ExternalLink]
		/** Datetime of last modification of the playlist (ISO 8601) */
		public var lastModifiedAt: Date
		/** Playlist name */
		public var name: String
		/** The type of the playlist */
		public var playlistType: PlaylistType
		/** Playlist description */
		public var description: String?
		/** Duration of playlist (ISO 8601) */
		public var duration: ISO8601Duration?
		/** Number of items in the playlist */
		public var numberOfItems: Int?

		public enum CodingKeys: String, CodingKey {

			case accessType
			case bounded
			case createdAt
			case externalLinks
			case lastModifiedAt
			case name
			case playlistType
			case description
			case duration
			case numberOfItems
		}

		public init(
			accessType: AccessType,
			bounded: Bool,
			createdAt: Date,
			externalLinks: [ExternalLink],
			lastModifiedAt: Date,
			name: String,
			playlistType: PlaylistType,
			description: String? = nil,
			duration: String? = nil,
			numberOfItems: Int? = nil
		) {
			self.accessType = accessType
			self.bounded = bounded
			self.createdAt = createdAt
			self.externalLinks = externalLinks
			self.lastModifiedAt = lastModifiedAt
			self.name = name
			self.playlistType = playlistType
			self.description = description
			self.duration = duration
			self.numberOfItems = numberOfItems
		}

		/** Access type */
		public enum AccessType: String, Codable, Equatable, CaseIterable, CustomStringConvertible, Sendable {
			case `public` = "PUBLIC"
			case unlisted = "UNLISTED"
			case undecoded

			public init(from decoder: Decoder) throws {
				let container = try decoder.singleValueContainer()
				let rawValue = try container.decode(String.self)
				self = AccessType(rawValue: rawValue) ?? .undecoded
			}

			public var description: String { rawValue }
		}

		/** The type of the playlist */
		public enum PlaylistType: String, Codable, Equatable, CaseIterable, CustomStringConvertible, Sendable {
			case editorial = "EDITORIAL"
			case user = "USER"
			case mix = "MIX"
			case artist = "ARTIST"
			case undecoded

			public init(from decoder: Decoder) throws {
				let container = try decoder.singleValueContainer()
				let rawValue = try container.decode(String.self)
				self = PlaylistType(rawValue: rawValue) ?? .undecoded
			}

			public var description: String { rawValue }
		}

		/** Privacy setting of the playlist */
		public enum Privacy: String, Codable, Equatable, CaseIterable, CustomStringConvertible, Sendable {
			case `public` = "PUBLIC"
			case `private` = "PRIVATE"
			case undecoded

			public init(from decoder: Decoder) throws {
				let container = try decoder.singleValueContainer()
				let rawValue = try container.decode(String.self)
				self = Privacy(rawValue: rawValue) ?? .undecoded
			}

			public var description: String { rawValue }
		}
	}
}
