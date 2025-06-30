import Foundation
import SwiftAPIClient

public extension TDO {

	struct SearchSuggestionsHighlights: Codable, Equatable, Sendable {

		public var length: Int
		public var start: Int

		public enum CodingKeys: String, CodingKey {

			case length
			case start
		}

		public init(
			length: Int,
			start: Int
		) {
			self.length = length
			self.start = start
		}
	}
}
