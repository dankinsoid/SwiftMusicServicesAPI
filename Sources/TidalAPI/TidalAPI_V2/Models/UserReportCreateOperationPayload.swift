import Foundation
import SwiftAPIClient

public extension TDO {

	struct UserReportCreateOperationPayload: Codable, Equatable, Sendable {

		public var data: UserReportCreateOperationPayloadData

		public enum CodingKeys: String, CodingKey {

			case data
		}

		public init(
			data: UserReportCreateOperationPayloadData
		) {
			self.data = data
		}
	}
}
