import Foundation
import SwiftAPIClient

public extension TDO {

	struct SearchSuggestionsRelationships: Codable, Equatable, Sendable {

		public var directHits: MultiDataRelationshipDoc

		public enum CodingKeys: String, CodingKey {

			case directHits
		}

		public init(
			directHits: MultiDataRelationshipDoc
		) {
			self.directHits = directHits
		}
	}
}
