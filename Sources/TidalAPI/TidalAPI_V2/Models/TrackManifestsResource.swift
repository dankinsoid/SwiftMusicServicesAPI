import Foundation
import SwiftAPIClient

public extension TDO {

	struct TrackManifestsResource: Codable, Equatable, Sendable {

		/** resource unique identifier */
		public var id: String
		/** resource unique type */
		public var type: String
		public var attributes: TrackManifestsAttributes?

		public enum CodingKeys: String, CodingKey {

			case id
			case type
			case attributes
		}

		public init(
			id: String,
			type: String = "trackManifests",
			attributes: TrackManifestsAttributes? = nil
		) {
			self.id = id
			self.type = type
			self.attributes = attributes
		}
	}
}
