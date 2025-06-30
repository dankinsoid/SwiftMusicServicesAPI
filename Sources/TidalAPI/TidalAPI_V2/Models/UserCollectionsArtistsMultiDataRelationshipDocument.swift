import Foundation
import SwiftAPIClient

public extension TDO {

	struct UserCollectionsArtistsMultiDataRelationshipDocument: Codable, Equatable, Sendable {

		public var data: [UserCollectionsArtistsResourceIdentifier]?
		public var links: Links?

		public enum CodingKeys: String, CodingKey {

			case data
			case links
		}

		public init(
			data: [UserCollectionsArtistsResourceIdentifier]? = nil,
			links: Links? = nil
		) {
			self.data = data
			self.links = links
		}
	}
}
