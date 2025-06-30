import Foundation
import SwiftAPIClient

public extension TDO {

	struct ArtistsTrackProvidersMultiDataRelationshipDocument: Codable, Equatable, Sendable {

		public var data: [ArtistsTrackProvidersResourceIdentifier]?
		public var links: Links?

		public enum CodingKeys: String, CodingKey {

			case data
			case links
		}

		public init(
			data: [ArtistsTrackProvidersResourceIdentifier]? = nil,
			links: Links? = nil
		) {
			self.data = data
			self.links = links
		}
	}
}
