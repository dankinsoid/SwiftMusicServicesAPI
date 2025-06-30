import Foundation
import SwiftAPIClient

public extension TDO {

	struct PlaylistUpdateOperationPayloadData: Codable, Equatable, Sendable {

		public var attributes: PlaylistUpdateOperationPayloadDataAttributes
		public var id: String
		public var type: TypeEnum

		public enum CodingKeys: String, CodingKey {

			case attributes
			case id
			case type
		}

		public init(
			attributes: PlaylistUpdateOperationPayloadDataAttributes,
			id: String,
			type: TypeEnum
		) {
			self.attributes = attributes
			self.id = id
			self.type = type
		}

		public enum TypeEnum: String, Codable, Equatable, CaseIterable, CustomStringConvertible, Sendable {
			case playlists
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
