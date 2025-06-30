import Foundation
import SwiftAPIClient

public extension TDO {

	struct ArtistUpdateBodyDataAttributes: Codable, Equatable, Sendable {

		public var contributionsEnabled: Bool?
		public var externalLinks: [ExternalLink]?
		public var handle: String?
		public var name: String?

		public enum CodingKeys: String, CodingKey {

			case contributionsEnabled
			case externalLinks
			case handle
			case name
		}

		public init(
			contributionsEnabled: Bool? = nil,
			externalLinks: [ExternalLink]? = nil,
			handle: String? = nil,
			name: String? = nil
		) {
			self.contributionsEnabled = contributionsEnabled
			self.externalLinks = externalLinks
			self.handle = handle
			self.name = name
		}
	}
}
