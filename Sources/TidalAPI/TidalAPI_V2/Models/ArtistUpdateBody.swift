import Foundation
import SwiftAPIClient

public extension TDO {

	struct ArtistUpdateBody: Codable, Equatable, Sendable {

		public var data: ArtistUpdateBodyData
		public var meta: ArtistUpdateBodyMeta?

		public enum CodingKeys: String, CodingKey {

			case data
			case meta
		}

		public init(
			data: ArtistUpdateBodyData,
			meta: ArtistUpdateBodyMeta? = nil
		) {
			self.data = data
			self.meta = meta
		}
	}
}
