import Foundation
import SwiftAPIClient

public extension TDO {

	struct UserCollectionsAlbumsMultiDataRelationshipDocument: Codable, Equatable, Sendable {

		public var data: [UserCollectionsAlbumsResourceIdentifier]?
		public var links: Links?

		public enum CodingKeys: String, CodingKey {

			case data
			case links
		}

		public init(
			data: [UserCollectionsAlbumsResourceIdentifier]? = nil,
			links: Links? = nil
		) {
			self.data = data
			self.links = links
		}
	}
}
