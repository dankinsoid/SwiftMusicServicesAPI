import Foundation
import SwiftAPIClient

public extension TDO {

	struct ArtistsTrackProvidersResourceIdentifierMeta: Codable, Equatable, Sendable {

		/** Total number of tracks released together with the provider */
		public var numberOfTracks: Int

		public enum CodingKeys: String, CodingKey {

			case numberOfTracks
		}

		public init(
			numberOfTracks: Int
		) {
			self.numberOfTracks = numberOfTracks
		}
	}
}
