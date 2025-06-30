import Foundation
import SwiftAPIClient

public extension TDO {

	struct SearchSuggestionsResource: Codable, Equatable, Sendable {

		/** resource unique identifier */
		public var id: String
		/** resource unique type */
		public var type: String
		public var attributes: SearchSuggestionsAttributes?
		public var relationships: SearchSuggestionsRelationships?

		public enum CodingKeys: String, CodingKey {

			case id
			case type
			case attributes
			case relationships
		}

		public init(
			id: String,
			type: String = "searchSuggestions",
			attributes: SearchSuggestionsAttributes? = nil,
			relationships: SearchSuggestionsRelationships? = nil
		) {
			self.id = id
			self.type = type
			self.attributes = attributes
			self.relationships = relationships
		}
	}
}
