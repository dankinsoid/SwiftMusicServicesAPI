import Foundation
import SwiftAPIClient

public extension TDO {

	/** Metadata about an artwork file */
	struct ArtworkFileMeta: Codable, Equatable, Sendable {

		/** Height (in pixels) */
		public var height: Int
		/** Width (in pixels) */
		public var width: Int

		public enum CodingKeys: String, CodingKey {

			case height
			case width
		}

		public init(
			height: Int,
			width: Int
		) {
			self.height = height
			self.width = width
		}
	}
}
