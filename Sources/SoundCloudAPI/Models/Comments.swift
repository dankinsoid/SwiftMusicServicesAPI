import Foundation
import SwiftAPIClient

public struct Comments: Codable, Equatable {

	public var collection: [Comment]?
	public var nextHref: String?

	public enum CodingKeys: String, CodingKey {

		case collection
		case nextHref = "next_href"
	}

	public init(
		collection: [Comment]? = nil,
		nextHref: String? = nil
	) {
		self.collection = collection
		self.nextHref = nextHref
	}
}
