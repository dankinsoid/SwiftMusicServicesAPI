import Foundation
import SwiftAPIClient

public extension TDO {

	/** Resource identifier JSON:API object */
	struct ResourceIdentifier: Codable, Equatable, Sendable {

		/** resource unique identifier */
		public var id: String
		/** resource unique type */
		public var type: String

		public enum CodingKeys: String, CodingKey {

			case id
			case type
		}

		public init(
			id: String,
			type: String
		) {
			self.id = id
			self.type = type
		}
	}
}
