import Foundation
import SwiftAPIClient

public extension TDO {

	struct PlaylistUpdateOperationPayload: Codable, Equatable, Sendable {

		public var data: PlaylistUpdateOperationPayloadData

		public enum CodingKeys: String, CodingKey {

			case data
		}

		public init(
			data: PlaylistUpdateOperationPayloadData
		) {
			self.data = data
		}
	}
}
