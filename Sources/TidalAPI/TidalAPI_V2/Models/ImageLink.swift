import Foundation
import SwiftAPIClient

public extension TDO {

	struct ImageLink: Codable, Equatable, Sendable {

		public var href: URL
		public var meta: ImageLinkMeta?

		public init(
			href: URL,
			meta: ImageLinkMeta? = nil
		) {
			self.href = href
			self.meta = meta
		}
	}

	struct ImageLinkMeta: Codable, Equatable, Sendable {

		public var width: Double?
		public var height: Double?

		public init(
			width: Double? = nil,
			height: Double? = nil
		) {
			self.width = width
			self.height = height
		}
	}
}
