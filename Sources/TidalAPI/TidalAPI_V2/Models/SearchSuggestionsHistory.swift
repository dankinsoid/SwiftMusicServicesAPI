import Foundation
import SwiftAPIClient

public extension TDO {

	/** Suggestions from search history */
	struct SearchSuggestionsHistory: Codable, Equatable, Sendable {

		public var query: String
		public var highlights: [SearchSuggestionsHighlights]?

		public enum CodingKeys: String, CodingKey {

			case query
			case highlights
		}

		public init(
			query: String,
			highlights: [SearchSuggestionsHighlights]? = nil
		) {
			self.query = query
			self.highlights = highlights
		}
	}
}
