import Foundation
import SwiftAPIClient

public extension TDO {

	struct UserCollectionsPlaylistsMultiDataRelationshipDocument: Codable, Equatable, Sendable {

		public var data: [UserCollectionsPlaylistsResourceIdentifier]?
		public var links: Links?

		public enum CodingKeys: String, CodingKey {

			case data
			case links
		}

		public init(
			data: [UserCollectionsPlaylistsResourceIdentifier]? = nil,
			links: Links? = nil
		) {
			self.data = data
			self.links = links
		}
	}
}
