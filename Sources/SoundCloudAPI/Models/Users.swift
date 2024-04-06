import Foundation
import SwiftAPIClient

public struct Users: Codable, Equatable, Pagination {

	public var collection: [User]?
	public var nextHref: String?

	public enum CodingKeys: String, CodingKey {

		case collection
		case nextHref = "next_href"
	}

	public init(
		collection: [User]? = nil,
		nextHref: String? = nil
	) {
		self.collection = collection
		self.nextHref = nextHref
	}
}
