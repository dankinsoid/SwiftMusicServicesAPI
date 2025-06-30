import Foundation
import SwiftAPIClient

public extension TDO {

	/** metadata for upload link */
	struct FileUploadLinkMeta: Codable, Equatable, Sendable {

		/** HTTP method */
		public var method: String
		/** HTTP headers that must be added to the operation */
		public var headers: [String: String]?

		public enum CodingKeys: String, CodingKey {

			case method
			case headers
		}

		public init(
			method: String,
			headers: [String: String]? = nil
		) {
			self.method = method
			self.headers = headers
		}
	}
}
