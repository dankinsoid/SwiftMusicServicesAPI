import Foundation
import SwiftAPIClient

public extension TDO {

	struct TrackFilesMultiDataDocument: Codable, Equatable, Sendable {

		public var data: [TrackFilesResource]?
		public var included: Included?
		public var links: Links?

		public enum CodingKeys: String, CodingKey {

			case data
			case included
			case links
		}

		public init(
			data: [TrackFilesResource]? = nil,
			included: Included? = nil,
			links: Links? = nil
		) {
			self.data = data
			self.included = included
			self.links = links
		}
	}
}
