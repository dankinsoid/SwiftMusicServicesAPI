import Foundation
import SwiftAPIClient

public extension TDO {

	struct ProvidersAttributes: Codable, Equatable, Sendable {

		/** Provider name */
		public var name: String

		public enum CodingKeys: String, CodingKey {

			case name
		}

		public init(
			name: String
		) {
			self.name = name
		}
	}
}
