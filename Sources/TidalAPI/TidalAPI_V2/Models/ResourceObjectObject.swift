import Foundation
import SwiftAPIClient
@preconcurrency import VDCodable

public extension TDO {

	struct ResourceObjectObject: Codable, Equatable, Sendable {

		/** resource unique identifier */
		public var id: String
		/** resource unique type */
		public var type: String
		public var attributes: [String: JSON]?
		public var relationships: [String: JSON]?

		public enum CodingKeys: String, CodingKey {

			case id
			case type
			case attributes
			case relationships
		}

		public init(
			id: String,
			type: String,
			attributes: [String: JSON]? = nil,
			relationships: [String: JSON]? = nil
		) {
			self.id = id
			self.type = type
			self.attributes = attributes
			self.relationships = relationships
		}
	}
}
