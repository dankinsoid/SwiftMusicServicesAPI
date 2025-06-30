import Foundation
import SwiftAPIClient

public extension TDO {

	struct UserCollectionArtistsRelationshipRemoveOperationPayloadData: Codable, Equatable, Sendable {

		public var id: String
		public var meta: UserCollectionArtistsRelationshipRemoveOperationPayloadDataMeta
		public var type: TypeEnum

		public enum CodingKeys: String, CodingKey {

			case id
			case meta
			case type
		}

		public init(
			id: String,
			meta: UserCollectionArtistsRelationshipRemoveOperationPayloadDataMeta,
			type: TypeEnum
		) {
			self.id = id
			self.meta = meta
			self.type = type
		}

		public enum TypeEnum: String, Codable, Equatable, CaseIterable, CustomStringConvertible, Sendable {
			case artists
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
