import Foundation
import SwiftAPIClient

public extension TDO {

	struct SearchResultsAttributes: Codable, Equatable, Sendable {

		/** search request unique tracking number */
		public var trackingId: String
		/** 'did you mean' prompt */
		public var didYouMean: String?

		public enum CodingKeys: String, CodingKey {

			case trackingId
			case didYouMean
		}

		public init(
			trackingId: String,
			didYouMean: String? = nil
		) {
			self.trackingId = trackingId
			self.didYouMean = didYouMean
		}
	}
}
