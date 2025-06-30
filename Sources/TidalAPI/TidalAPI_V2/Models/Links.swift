import Foundation
import SwiftAPIClient

public extension TDO {

	/** Links JSON:API object */
	struct Links: Codable, Equatable, Sendable {

		/** Link to self */
		public var this: String
		/** Link to next page */
		public var next: String?

		public enum CodingKeys: String, CodingKey {

			case this = "self"
			case next
		}

		public init(
			this: String,
			next: String? = nil
		) {
			self.this = this
			self.next = next
		}
	}
}
