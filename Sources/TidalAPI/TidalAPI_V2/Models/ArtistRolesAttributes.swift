import Foundation
import SwiftAPIClient

public extension TDO {

	struct ArtistRolesAttributes: Codable, Equatable, Sendable {

		public var name: String?

		public enum CodingKeys: String, CodingKey {

			case name
		}

		public init(
			name: String? = nil
		) {
			self.name = name
		}
	}
}
