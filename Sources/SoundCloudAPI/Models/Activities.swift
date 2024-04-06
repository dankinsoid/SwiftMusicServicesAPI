import Foundation
import SwiftAPIClient

/** User's activities. */
public struct Activities: Codable, Equatable, Pagination {

	public var collection: [Collection]?
	public var futureHref: String?
	public var nextHref: String?

	public enum CodingKeys: String, CodingKey {

		case collection
		case futureHref = "future_href"
		case nextHref = "next_href"
	}

	public init(
		collection: [Collection]? = nil,
		futureHref: String? = nil,
		nextHref: String? = nil
	) {
		self.collection = collection
		self.futureHref = futureHref
		self.nextHref = nextHref
	}

	/** User's activities. */
	public struct Collection: Codable, Equatable {

		/** Created timestamp. */
		public var createdAt: String?
		/** Origin. */
		public var origin: Origin?
		/** Type of activity (track). */
		public var type: String?

		public enum CodingKeys: String, CodingKey {

			case createdAt = "created_at"
			case origin
			case type
		}

		public init(
			createdAt: String? = nil,
			origin: Origin? = nil,
			type: String? = nil
		) {
			self.createdAt = createdAt
			self.origin = origin
			self.type = type
		}
	}
}
