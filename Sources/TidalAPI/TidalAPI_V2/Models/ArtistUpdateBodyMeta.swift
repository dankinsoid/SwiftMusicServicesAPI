import Foundation
import SwiftAPIClient

public extension TDO {

	struct ArtistUpdateBodyMeta: Codable, Equatable, Sendable {

		public var dryRun: Bool?

		public enum CodingKeys: String, CodingKey {

			case dryRun
		}

		public init(
			dryRun: Bool? = nil
		) {
			self.dryRun = dryRun
		}
	}
}
