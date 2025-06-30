import Foundation
import SwiftAPIClient

public extension TDO {

	struct PlaylistCreateOperationPayload: Codable, Equatable, Sendable {

		public var data: PlaylistCreateOperationPayloadData

		public enum CodingKeys: String, CodingKey {

			case data
		}

		public init(
			data: PlaylistCreateOperationPayloadData
		) {
			self.data = data
		}
	}
}
