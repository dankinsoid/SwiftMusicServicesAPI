import Foundation
import SwiftAPIClient

public extension TDO {

	struct ReportedResource: Codable, Equatable, Sendable {

		public var id: String
		public var type: TypeEnum

		public enum CodingKeys: String, CodingKey {

			case id
			case type
		}

		public init(
			id: String,
			type: TypeEnum
		) {
			self.id = id
			self.type = type
		}

		public enum TypeEnum: String, Codable, Equatable, CaseIterable, CustomStringConvertible, Sendable {
			case tracks
			case artists
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
