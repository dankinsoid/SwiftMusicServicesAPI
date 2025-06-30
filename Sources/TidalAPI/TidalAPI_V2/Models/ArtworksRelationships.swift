import Foundation
import SwiftAPIClient

public extension TDO {

	struct ArtworksRelationships: Codable, Equatable, Sendable {

		public var owners: MultiDataRelationshipDoc

		public enum CodingKeys: String, CodingKey {

			case owners
		}

		public init(
			owners: MultiDataRelationshipDoc
		) {
			self.owners = owners
		}
	}
}
