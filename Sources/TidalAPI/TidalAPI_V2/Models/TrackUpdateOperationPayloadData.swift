import Foundation
import SwiftAPIClient

public extension TDO {

	struct TrackUpdateOperationPayloadData: Codable, Equatable, Sendable {

		public var attributes: TrackUpdateOperationPayloadDataAttributes
		public var id: String
		public var type: TypeEnum

		public enum CodingKeys: String, CodingKey {

			case attributes
			case id
			case type
		}

		public init(
			attributes: TrackUpdateOperationPayloadDataAttributes,
			id: String,
			type: TypeEnum
		) {
			self.attributes = attributes
			self.id = id
			self.type = type
		}

		public enum TypeEnum: String, Codable, Equatable, CaseIterable, CustomStringConvertible, Sendable {
			case tracks
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
