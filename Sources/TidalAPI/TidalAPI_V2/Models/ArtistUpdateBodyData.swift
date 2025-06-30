import Foundation
import SwiftAPIClient

public extension TDO {

	struct ArtistUpdateBodyData: Codable, Equatable, Sendable {

		public var attributes: ArtistUpdateBodyDataAttributes
		public var id: String
		public var type: TypeEnum

		public enum CodingKeys: String, CodingKey {

			case attributes
			case id
			case type
		}

		public init(
			attributes: ArtistUpdateBodyDataAttributes,
			id: String,
			type: TypeEnum
		) {
			self.attributes = attributes
			self.id = id
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
