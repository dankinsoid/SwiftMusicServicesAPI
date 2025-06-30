import Foundation
import SwiftAPIClient

public extension TDO {

	struct UserRecommendationsRelationships: Codable, Equatable, Sendable {

		public var discoveryMixes: MultiDataRelationshipDoc
		public var myMixes: MultiDataRelationshipDoc
		public var newArrivalMixes: MultiDataRelationshipDoc

		public enum CodingKeys: String, CodingKey {

			case discoveryMixes
			case myMixes
			case newArrivalMixes
		}

		public init(
			discoveryMixes: MultiDataRelationshipDoc,
			myMixes: MultiDataRelationshipDoc,
			newArrivalMixes: MultiDataRelationshipDoc
		) {
			self.discoveryMixes = discoveryMixes
			self.myMixes = myMixes
			self.newArrivalMixes = newArrivalMixes
		}
	}
}
