import Foundation
import SwiftAPIClient

public extension TDO {

	struct PlaylistUpdateOperationPayloadDataAttributes: Codable, Equatable, Sendable {

		/** Access type */
		public var accessType: AccessType?
		public var description: String?
		public var name: String?

		public enum CodingKeys: String, CodingKey {

			case accessType
			case description
			case name
		}

		public init(
			accessType: AccessType? = nil,
			description: String? = nil,
			name: String? = nil
		) {
			self.accessType = accessType
			self.description = description
			self.name = name
		}

		/** Access type */
		public enum AccessType: String, Codable, Equatable, CaseIterable, CustomStringConvertible, Sendable {
			case `public` = "PUBLIC"
			case unlisted = "UNLISTED"
			case undecoded

			public init(from decoder: Decoder) throws {
				let container = try decoder.singleValueContainer()
				let rawValue = try container.decode(String.self)
				self = AccessType(rawValue: rawValue) ?? .undecoded
			}

			public var description: String { rawValue }
		}
	}
}
