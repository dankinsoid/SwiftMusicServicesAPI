import Foundation
import SwiftAPIClient

public extension TDO {

	/** JSON:API error document object */
	struct ErrorDocument: Codable, Equatable, Sendable, Swift.Error, CustomStringConvertible {

		/** array of error objects */
		public var errors: [ErrorObject]?
		public var links: Links?

		public var description: String {
			if let errors, !errors.isEmpty {
				return "[\n\(errors.map(\.description).joined(separator: "\n"))\n]"
			} else {
				return "No error details available."
			}
		}

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
