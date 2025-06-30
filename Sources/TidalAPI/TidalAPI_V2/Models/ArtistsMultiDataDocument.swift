import Foundation
import SwiftAPIClient

public extension TDO {

	struct ArtistsMultiDataDocument: Codable, Equatable, Sendable {

		public var data: [ArtistsResource]?
		public var included: Included?
		public var links: Links?

		public enum CodingKeys: String, CodingKey {

			case data
			case included
			case links
		}

		public init(
			data: [ArtistsResource]? = nil,
			included: Included? = nil,
			links: Links? = nil
		) {
			self.data = data
			self.included = included
			self.links = links
		}
	}
}
