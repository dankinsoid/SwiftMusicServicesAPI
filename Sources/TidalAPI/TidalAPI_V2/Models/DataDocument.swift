import Foundation
import SwiftAPIClient

public extension TDO {

	struct DataDocument<Data: Codable>: Codable {

		public var data: Data?
		public var included: Included?
		public var links: Links?

		public init(
			data: Data? = nil,
			included: Included? = nil,
			links: Links? = nil
		) {
			self.data = data
			self.included = included
			self.links = links
		}
	}
}

extension TDO.DataDocument: Equatable where Data: Equatable {}

extension TDO.DataDocument: Sendable where Data: Sendable {}
