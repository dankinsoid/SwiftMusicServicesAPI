import Foundation
import SwiftAPIClient

public extension TDO {

	struct UserReportCreateOperationPayloadData: Codable, Equatable, Sendable {

		public var attributes: UserReportCreateOperationPayloadDataAttributes
		public var relationships: UserReportsCreateOperationPayloadDataRelationships
		public var type: TypeEnum

		public enum CodingKeys: String, CodingKey {

			case attributes
			case relationships
			case type
		}

		public init(
			attributes: UserReportCreateOperationPayloadDataAttributes,
			relationships: UserReportsCreateOperationPayloadDataRelationships,
			type: TypeEnum
		) {
			self.attributes = attributes
			self.relationships = relationships
			self.type = type
		}

		public enum TypeEnum: String, Codable, Equatable, CaseIterable, CustomStringConvertible, Sendable {
			case userReports
			case undecoded

			public init(from decoder: Decoder) throws {
				let container = try decoder.singleValueContainer()
				let rawValue = try container.decode(String.self)
				self = TypeEnum(rawValue: rawValue) ?? .undecoded
			}

			public var description: String { rawValue }
		}
	}
}
