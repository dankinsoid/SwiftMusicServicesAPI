import Foundation
import SwiftAPIClient

public extension TDO {

	struct ArtistsAttributes: Codable, Equatable, Sendable {

		/** Artist name */
		public var name: String
		/** Artist popularity (0.0 - 1.0) */
		public var popularity: Double
		/** Is the artist enabled for contributions? */
		public var contributionsEnabled: Bool?
		/** Artist links external to TIDAL API */
		public var externalLinks: [ExternalLink]?
		/** Artist handle */
		public var handle: String?
		/** Is the artist spotlighted? */
		public var spotlighted: Bool?

		public enum CodingKeys: String, CodingKey {

			case name
			case popularity
			case contributionsEnabled
			case externalLinks
			case handle
			case spotlighted
		}

		public init(
			name: String,
			popularity: Double,
			contributionsEnabled: Bool? = nil,
			externalLinks: [ExternalLink]? = nil,
			handle: String? = nil,
			spotlighted: Bool? = nil
		) {
			self.name = name
			self.popularity = popularity
			self.contributionsEnabled = contributionsEnabled
			self.externalLinks = externalLinks
			self.handle = handle
			self.spotlighted = spotlighted
		}
	}
}
