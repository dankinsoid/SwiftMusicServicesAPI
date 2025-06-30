import Foundation
import SwiftAPIClient

public extension TDO {

	struct UserEntitlementsAttributes: Codable, Equatable, Sendable {

		/** entitlements for user */
		public var entitlements: [Entitlements]

		public enum CodingKeys: String, CodingKey {

			case entitlements
		}

		public init(
			entitlements: [Entitlements]
		) {
			self.entitlements = entitlements
		}

		/** entitlements for user */
		public enum Entitlements: String, Codable, Equatable, CaseIterable, CustomStringConvertible, Sendable {
			case music = "MUSIC"
			case dj = "DJ"
			case undecoded

			public init(from decoder: Decoder) throws {
				let container = try decoder.singleValueContainer()
				let rawValue = try container.decode(String.self)
				self = Entitlements(rawValue: rawValue) ?? .undecoded
			}

			public var description: String { rawValue }
		}
	}
}
