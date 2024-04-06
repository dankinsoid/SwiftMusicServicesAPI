import Foundation
import SwiftAPIClient

public struct Playlists: Codable, Equatable, Pagination {

	public var collection: [Playlist]?
	public var nextHref: String?

	public enum CodingKeys: String, CodingKey {

		case collection
		case nextHref = "next_href"
	}

	public init(
		collection: [Playlist]? = nil,
		nextHref: String? = nil
	) {
		self.collection = collection
		self.nextHref = nextHref
	}
}
