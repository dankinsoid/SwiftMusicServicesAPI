import Foundation
import SwiftAPIClient

public extension TDO {

	struct PlaylistItemsRelationshipRemoveOperationPayloadData: Codable, Equatable, Sendable {

		public var id: String
		public var meta: PlaylistItemsRelationshipRemoveOperationPayloadDataMeta
		public var type: TypeEnum

		public enum CodingKeys: String, CodingKey {

			case id
			case meta
			case type
		}

		public init(
			id: String,
			meta: PlaylistItemsRelationshipRemoveOperationPayloadDataMeta,
			type: TypeEnum
		) {
			self.id = id
			self.meta = meta
			self.type = type
		}

		public enum TypeEnum: String, Codable, Equatable, CaseIterable, CustomStringConvertible, Sendable {
			case tracks
			case videos
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
