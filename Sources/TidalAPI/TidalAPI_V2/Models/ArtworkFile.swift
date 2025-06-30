import Foundation
import SwiftAPIClient

public extension TDO {

	/** Artwork files */
	struct ArtworkFile: Codable, Equatable, Sendable {

		/** Artwork file href */
		public var href: String
		public var meta: ArtworkFileMeta?

		public enum CodingKeys: String, CodingKey {

			case href
			case meta
		}

		public init(
			href: String,
			meta: ArtworkFileMeta? = nil
		) {
			self.href = href
			self.meta = meta
		}
	}
}
