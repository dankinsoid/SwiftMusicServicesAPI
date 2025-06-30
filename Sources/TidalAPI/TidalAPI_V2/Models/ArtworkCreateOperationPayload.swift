import Foundation
import SwiftAPIClient

public extension TDO {

	struct ArtworkCreateOperationPayload: Codable, Equatable, Sendable {

		public var data: ArtworkCreateOperationPayloadData

		public enum CodingKeys: String, CodingKey {

			case data
		}

		public init(
			data: ArtworkCreateOperationPayloadData
		) {
			self.data = data
		}
	}
}
