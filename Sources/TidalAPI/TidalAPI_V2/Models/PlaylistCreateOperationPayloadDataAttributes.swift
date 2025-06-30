import Foundation
import SwiftAPIClient

public extension TDO {

	struct PlaylistCreateOperationPayloadDataAttributes: Codable, Equatable, Sendable {

		public var name: String
		/** Access type */
		public var accessType: AccessType?
		public var description: String?

		public enum CodingKeys: String, CodingKey {

			case name
			case accessType
			case description
		}

		public init(
			name: String,
			accessType: AccessType? = nil,
			description: String? = nil
		) {
			self.name = name
			self.accessType = accessType
			self.description = description
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
