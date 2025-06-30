import Foundation
import SwiftAPIClient

public extension TDO {

	/** Upload link */
	struct FileUploadLink: Codable, Equatable, Sendable {

		/** Href to upload actual file to */
		public var href: String
		public var meta: FileUploadLinkMeta

		public enum CodingKeys: String, CodingKey {

			case href
			case meta
		}

		public init(
			href: String,
			meta: FileUploadLinkMeta
		) {
			self.href = href
			self.meta = meta
		}
	}
}
