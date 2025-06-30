import Foundation
import SwiftAPIClient

public extension TDO {

	struct AlbumsItemsResourceIdentifierMeta: Codable, Equatable, Sendable {

		/** track number */
		public var trackNumber: Int
		/** volume number */
		public var volumeNumber: Int

		public enum CodingKeys: String, CodingKey {

			case trackNumber
			case volumeNumber
		}

		public init(
			trackNumber: Int,
			volumeNumber: Int
		) {
			self.trackNumber = trackNumber
			self.volumeNumber = volumeNumber
		}
	}
}
