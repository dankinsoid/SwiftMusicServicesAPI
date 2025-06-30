import Foundation
import SwiftAPIClient

public extension TDO {

	struct MultiDataRelationshipDoc: Codable, Equatable, Sendable {

		public var data: [ResourceIdentifier]?
		public var links: Links?

		public enum CodingKeys: String, CodingKey {

			case data
			case links
		}

		public init(
			data: [ResourceIdentifier]? = nil,
			links: Links? = nil
		) {
			self.data = data
			self.links = links
		}
	}
}
