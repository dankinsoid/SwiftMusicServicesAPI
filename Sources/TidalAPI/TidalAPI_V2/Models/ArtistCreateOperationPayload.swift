import Foundation
import SwiftAPIClient

public extension TDO {

	struct ArtistCreateOperationPayload: Codable, Equatable, Sendable {

		public var data: ArtistCreateOperationPayloadData
		public var meta: ArtistCreateOperationMeta?

		public enum CodingKeys: String, CodingKey {

			case data
			case meta
		}

		public init(
			data: ArtistCreateOperationPayloadData,
			meta: ArtistCreateOperationMeta? = nil
		) {
			self.data = data
			self.meta = meta
		}
	}
}
