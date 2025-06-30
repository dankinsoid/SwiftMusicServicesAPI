import Foundation
import SwiftAPIClient

public extension TDO {

	/** JSON:API error document object */
	struct ErrorDocument: Codable, Equatable, Sendable, Swift.Error {

		/** array of error objects */
		public var errors: [ErrorObject]?
		public var links: Links?

		public enum CodingKeys: String, CodingKey {

			case errors
			case links
		}

		public init(
			errors: [ErrorObject]? = nil,
			links: Links? = nil
		) {
			self.errors = errors
			self.links = links
		}
	}
}
