import Foundation
import SwiftAPIClient

public extension TDO {

	struct SearchSuggestionsAttributes: Codable, Equatable, Sendable {

		/** Unique tracking id */
		public var trackingId: String
		/** Suggestions from search history */
		public var history: [SearchSuggestionsHistory]?
		/** Suggested search queries */
		public var suggestions: [SearchSuggestionsSuggestions]?

		public enum CodingKeys: String, CodingKey {

			case trackingId
			case history
			case suggestions
		}

		public init(
			trackingId: String,
			history: [SearchSuggestionsHistory]? = nil,
			suggestions: [SearchSuggestionsSuggestions]? = nil
		) {
			self.trackingId = trackingId
			self.history = history
			self.suggestions = suggestions
		}
	}
}
