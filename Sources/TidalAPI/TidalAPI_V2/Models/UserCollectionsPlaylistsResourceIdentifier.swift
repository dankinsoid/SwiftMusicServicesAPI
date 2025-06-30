import Foundation
import SwiftAPIClient

public extension TDO {

	/** Resource identifier JSON:API object */
	struct UserCollectionsPlaylistsResourceIdentifier: Codable, Equatable, Sendable {

		/** resource unique identifier */
		public var id: String
		/** resource unique type */
		public var type: String
		public var meta: UserCollectionsPlaylistsResourceIdentifierMeta?

		public enum CodingKeys: String, CodingKey {

			case id
			case type
			case meta
		}

		public init(
			id: String,
			type: String,
			meta: UserCollectionsPlaylistsResourceIdentifierMeta? = nil
		) {
			self.id = id
			self.type = type
			self.meta = meta
		}
	}
}
