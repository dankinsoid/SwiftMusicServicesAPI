import Foundation
import SwiftAPIClient

public struct Tracks: Codable, Equatable, Pagination {

	public var collection: [Track]?
	public var nextHref: String?

	public enum CodingKeys: String, CodingKey {

		case collection
		case nextHref = "next_href"
	}

	public init(
		collection: [Track]? = nil,
		nextHref: String? = nil
	) {
		self.collection = collection
		self.nextHref = nextHref
	}
}
