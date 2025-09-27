import Foundation
import SwiftAPIClient

public extension TDO {

	struct DataDocument<Data> {

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

extension TDO.DataDocument: Encodable where Data: Encodable {}
extension TDO.DataDocument: Decodable where Data: Decodable {}
extension TDO.DataDocument: Equatable where Data: Equatable {}
extension TDO.DataDocument: Sendable where Data: Sendable {}

extension TDO.DataDocument: Mockable {
	
	public static var mock: TDO.DataDocument<Data> {
		TDO.DataDocument(
			data: (Data.self as? Mockable.Type)?.mock as? Data,
			included: nil,
			links: .mock
		)
	}
}
