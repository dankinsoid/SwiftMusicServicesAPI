import Foundation
import SwiftAPIClient

public extension TDO {

	struct ArtistCreateOperationPayloadDataAttributes: Codable, Equatable, Sendable {

		public var name: String
		public var handle: String?

		public enum CodingKeys: String, CodingKey {

			case name
			case handle
		}

		public init(
			name: String,
			handle: String? = nil
		) {
			self.name = name
			self.handle = handle
		}
	}
}
