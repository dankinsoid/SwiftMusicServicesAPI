import Foundation
import SwiftAPIClient

public extension TDO {

	/** Resource identifier JSON:API object */
	struct ArtistsTrackProvidersResourceIdentifier: Codable, Equatable, Sendable {

		/** resource unique identifier */
		public var id: String
		/** resource unique type */
		public var type: String
		public var meta: ArtistsTrackProvidersResourceIdentifierMeta?

		public enum CodingKeys: String, CodingKey {

			case id
			case type
			case meta
		}

		public init(
			id: String,
			type: String,
			meta: ArtistsTrackProvidersResourceIdentifierMeta? = nil
		) {
			self.id = id
			self.type = type
			self.meta = meta
		}
	}
}
