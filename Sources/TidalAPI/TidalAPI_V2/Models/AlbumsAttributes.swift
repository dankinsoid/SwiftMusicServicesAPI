import Foundation
import SwiftAPIClient
import SwiftMusicServicesApi

public extension TDO {

	struct AlbumsAttributes: Codable, Equatable, Sendable {

		/** Barcode id (EAN-13 or UPC-A) */
		public var barcodeId: String
		/** Duration (ISO 8601) */
		public var duration: ISO8601Duration
		/** Explicit content */
		public var explicit: Bool
		public var mediaTags: [String]
		/** Number of items in album */
		public var numberOfItems: Int
		/** Number of volumes */
		public var numberOfVolumes: Int
		/** Popularity (0.0 - 1.0) */
		public var popularity: Double
		/** Album title */
		public var title: String
		/** Album type */
		public var type: TypeEnum
		/** Available usage for this album */
		public var availability: [Availability]?
		/** Copyright */
		public var copyright: String?
		/** Album links external to TIDAL API */
		public var externalLinks: [ExternalLink]?
		/** Release date (ISO-8601) */
		public var releaseDate: Date?

		public enum CodingKeys: String, CodingKey {

			case barcodeId
			case duration
			case explicit
			case mediaTags
			case numberOfItems
			case numberOfVolumes
			case popularity
			case title
			case type
			case availability
			case copyright
			case externalLinks
			case releaseDate
		}

		public init(
			barcodeId: String,
			duration: String,
			explicit: Bool,
			mediaTags: [String],
			numberOfItems: Int,
			numberOfVolumes: Int,
			popularity: Double,
			title: String,
			type: TypeEnum,
			availability: [Availability]? = nil,
			copyright: String? = nil,
			externalLinks: [ExternalLink]? = nil,
			releaseDate: Date? = nil
		) {
			self.barcodeId = barcodeId
			self.duration = duration
			self.explicit = explicit
			self.mediaTags = mediaTags
			self.numberOfItems = numberOfItems
			self.numberOfVolumes = numberOfVolumes
			self.popularity = popularity
			self.title = title
			self.type = type
			self.availability = availability
			self.copyright = copyright
			self.externalLinks = externalLinks
			self.releaseDate = releaseDate
		}

		/** Album type */
		public enum TypeEnum: String, Codable, Equatable, CaseIterable, CustomStringConvertible, Sendable {
			case album = "ALBUM"
			case ep = "EP"
			case single = "SINGLE"
			case undecoded

			public init(from decoder: Decoder) throws {
				let container = try decoder.singleValueContainer()
				let rawValue = try container.decode(String.self)
				self = TypeEnum(rawValue: rawValue) ?? .undecoded
			}

			public var description: String { rawValue }
		}

		/** Available usage for this album */
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
