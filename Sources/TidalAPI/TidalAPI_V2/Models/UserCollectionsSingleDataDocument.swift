import Foundation
import SwiftAPIClient

public extension TDO {

	struct UserCollectionsSingleDataDocument: Codable, Equatable, Sendable {

		public var data: UserCollectionsResource?
		public var included: Included?
		public var links: Links?

		public enum CodingKeys: String, CodingKey {

			case data
			case included
			case links
		}

		public init(
			data: UserCollectionsResource? = nil,
			included: Included? = nil,
			links: Links? = nil
		) {
			self.data = data
			self.included = included
			self.links = links
		}
	}
}
