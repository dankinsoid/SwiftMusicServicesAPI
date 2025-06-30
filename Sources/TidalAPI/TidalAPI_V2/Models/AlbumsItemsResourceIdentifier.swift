import Foundation
import SwiftAPIClient

public extension TDO {

	/** Resource identifier JSON:API object */
	struct AlbumsItemsResourceIdentifier: Codable, Equatable, Sendable {

		/** resource unique identifier */
		public var id: String
		/** resource unique type */
		public var type: String
		public var meta: AlbumsItemsResourceIdentifierMeta?

		public enum CodingKeys: String, CodingKey {

			case id
			case type
			case meta
		}

		public init(
			id: String,
			type: String,
			meta: AlbumsItemsResourceIdentifierMeta? = nil
		) {
			self.id = id
			self.type = type
			self.meta = meta
		}
	}
}
