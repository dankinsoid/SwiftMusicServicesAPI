import Foundation
import SwiftAPIClient

public extension TDO {

	struct PlaylistCreateOperationPayloadData: Codable, Equatable, Sendable {

		public var attributes: PlaylistCreateOperationPayloadDataAttributes
		public var type: TypeEnum

		public enum CodingKeys: String, CodingKey {

			case attributes
			case type
		}

		public init(
			attributes: PlaylistCreateOperationPayloadDataAttributes,
			type: TypeEnum
		) {
			self.attributes = attributes
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
