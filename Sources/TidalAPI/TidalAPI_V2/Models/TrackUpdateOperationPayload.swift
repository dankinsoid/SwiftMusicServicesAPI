import Foundation
import SwiftAPIClient

public extension TDO {

	struct TrackUpdateOperationPayload: Codable, Equatable, Sendable {

		public var data: TrackUpdateOperationPayloadData

		public enum CodingKeys: String, CodingKey {

			case data
		}

		public init(
			data: TrackUpdateOperationPayloadData
		) {
			self.data = data
		}
	}
}
