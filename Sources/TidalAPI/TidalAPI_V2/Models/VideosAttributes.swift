import Foundation
import SwiftAPIClient
import SwiftMusicServicesApi

public extension TDO {

	struct VideosAttributes: Codable, Equatable, Sendable {

		/** Duration (ISO 8601) */
		public var duration: ISO8601Duration
		/** Explicit content */
		public var explicit: Bool
		/** International Standard Recording Code (ISRC) */
		public var isrc: String
		/** Popularity (0.0 - 1.0) */
		public var popularity: Double
		/** Video title */
		public var title: String
		/** Available usage for this video */
		public var availability: [Availability]?
		/** Copyright */
		public var copyright: String?
		/** Video links external to TIDAL API */
		public var externalLinks: [ExternalLink]?
		/** Release date (ISO-8601) */
		public var releaseDate: Date?
		/** Video version, complements title */
		public var version: String?

		public enum CodingKeys: String, CodingKey {

			case duration
			case explicit
			case isrc
			case popularity
			case title
			case availability
			case copyright
			case externalLinks
			case releaseDate
			case version
		}

		public init(
			duration: String,
			explicit: Bool,
			isrc: String,
			popularity: Double,
			title: String,
			availability: [Availability]? = nil,
			copyright: String? = nil,
			externalLinks: [ExternalLink]? = nil,
			releaseDate: Date? = nil,
			version: String? = nil
		) {
			self.duration = duration
			self.explicit = explicit
			self.isrc = isrc
			self.popularity = popularity
			self.title = title
			self.availability = availability
			self.copyright = copyright
			self.externalLinks = externalLinks
			self.releaseDate = releaseDate
			self.version = version
		}

		/** Available usage for this video */
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
	}
}
