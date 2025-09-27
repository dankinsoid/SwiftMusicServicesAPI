import Foundation
import SwiftAPIClient

public extension TDO {

	struct SearchResultsResource: Codable, Equatable, Sendable {

		/** resource unique identifier */
		public var id: String
		/** resource unique type */
		public var type: String
		public var attributes: SearchResultsAttributes?
		public var relationships: SearchResultsRelationships?

		public enum CodingKeys: String, CodingKey {

			case id
			case type
			case attributes
			case relationships
		}

		public init(
			id: String,
			type: String = "searchResults",
			attributes: SearchResultsAttributes? = nil,
			relationships: SearchResultsRelationships? = nil
		) {
			self.id = id
			self.type = type
			self.attributes = attributes
			self.relationships = relationships
		}
	}
}

extension TDO.SearchResultsResource: Mockable {
	
	public static let mock = TDO.SearchResultsResource(
		id: "searchResults-123456",
		attributes: nil,
		relationships: nil
	)
}
