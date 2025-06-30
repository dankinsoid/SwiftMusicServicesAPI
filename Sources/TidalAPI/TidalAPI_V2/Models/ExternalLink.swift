import Foundation
import SwiftAPIClient

public extension TDO {

	struct ExternalLink: Codable, Equatable, Sendable {

		public var href: String
		public var meta: ExternalLinkMeta

		public enum CodingKeys: String, CodingKey {

			case href
			case meta
		}

		public init(
			href: String,
			meta: ExternalLinkMeta
		) {
			self.href = href
			self.meta = meta
		}
	}
}
