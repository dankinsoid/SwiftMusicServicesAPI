import Foundation
import SwiftAPIClient
import SwiftMusicServicesApi

public extension TDO {

	struct TracksAttributes: Codable, Equatable, Sendable {

		/** Duration (ISO 8601) */
		public var duration: ISO8601Duration
		/** Explicit content */
		public var explicit: Bool?
		/** International Standard Recording Code (ISRC) */
		public var isrc: String?
		public var mediaTags: [String]?
		/** Popularity (0.0 - 1.0) */
		public var popularity: Double?
		/** Track title */
		public var title: String
		/** Access type */
		public var accessType: AccessType?
		/** Available usage for this track */
		public var availability: [Availability]?
		/** Beats per minute */
		public var bpm: Float?
		/** Copyright */
		/** Track links external to TIDAL API */
		public var externalLinks: [ExternalLink]?
		public var imageLinks: [ImageLink]?
		public var genreTags: [String]?
		/** Key */
		public var key: Key?
		/** The scale of the key */
		public var keyScale: KeyScale?
		/** Is the track spotlighted? */
		public var spotlighted: Bool?
		public var toneTags: [String]?
		/** Track version, complements title */
		public var version: String?

		public init(
			duration: ISO8601Duration,
			explicit: Bool? = nil,
			isrc: String? = nil,
			mediaTags: [String] = [],
			popularity: Double? = nil,
			title: String,
			accessType: AccessType? = nil,
			availability: [Availability]? = nil,
			bpm: Float? = nil,
			externalLinks: [ExternalLink]? = nil,
			imageLinks: [ImageLink]? = nil,
			genreTags: [String]? = nil,
			key: Key? = nil,
			keyScale: KeyScale? = nil,
			spotlighted: Bool? = nil,
			toneTags: [String]? = nil,
			version: String? = nil
		) {
			self.duration = duration
			self.explicit = explicit
			self.isrc = isrc
			self.mediaTags = mediaTags
			self.popularity = popularity
			self.title = title
			self.accessType = accessType
			self.availability = availability
			self.bpm = bpm
			self.externalLinks = externalLinks
			self.imageLinks = imageLinks
			self.genreTags = genreTags
			self.key = key
			self.keyScale = keyScale
			self.spotlighted = spotlighted
			self.toneTags = toneTags
			self.version = version
		}

		/** Access type */
		public enum AccessType: String, Codable, Equatable, CaseIterable, CustomStringConvertible, Sendable {
			case `public` = "PUBLIC"
			case unlisted = "UNLISTED"
			case `private` = "PRIVATE"
			case undecoded

			public init(from decoder: Decoder) throws {
				let container = try decoder.singleValueContainer()
				let rawValue = try container.decode(String.self)
				self = AccessType(rawValue: rawValue) ?? .undecoded
			}

			public var description: String { rawValue }
		}

		/** Available usage for this track */
		public enum Availability: String, Codable, Equatable, CaseIterable, CustomStringConvertible, Sendable {
			case stream = "STREAM"
			case dj = "DJ"
			case stem = "STEM"
			case undecoded

			public init(from decoder: Decoder) throws {
				let container = try decoder.singleValueContainer()
				let rawValue = try container.decode(String.self)
				self = Availability(rawValue: rawValue) ?? .undecoded
			}

			public var description: String { rawValue }
		}

		/** Key */
		public enum Key: String, Codable, Equatable, CaseIterable, CustomStringConvertible, Sendable {
			case a = "A"
			case ab = "Ab"
			case b = "B"
			case bb = "Bb"
			case c = "C"
			case cSharp = "CSharp"
			case d = "D"
			case e = "E"
			case eb = "Eb"
			case f = "F"
			case fSharp = "FSharp"
			case g = "G"
			case undecoded

			public init(from decoder: Decoder) throws {
				let container = try decoder.singleValueContainer()
				let rawValue = try container.decode(String.self)
				self = Key(rawValue: rawValue) ?? .undecoded
			}

			public var description: String { rawValue }
		}

		/** The scale of the key */
		public enum KeyScale: String, Codable, Equatable, CaseIterable, CustomStringConvertible, Sendable {
			case major = "MAJOR"
			case minor = "MINOR"
			case undecoded

			public init(from decoder: Decoder) throws {
				let container = try decoder.singleValueContainer()
				let rawValue = try container.decode(String.self)
				self = KeyScale(rawValue: rawValue) ?? .undecoded
			}

			public var description: String { rawValue }
		}
	}
}
