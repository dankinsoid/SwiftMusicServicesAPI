import Foundation
import SwiftAPIClient

public extension TDO {

	struct ExternalLink: Codable, Equatable, Sendable {

		public var href: URL
		public var meta: ExternalLinkMeta?

		public enum CodingKeys: String, CodingKey {

			case href
			case meta
		}

		public init(
			href: URL,
			meta: ExternalLinkMeta? = nil
		) {
			self.href = href
			self.meta = meta
		}
	}
}
