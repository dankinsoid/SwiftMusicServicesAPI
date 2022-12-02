import Foundation
import VDCodable

public extension VK.Objects {
	struct Response<Value: Decodable>: Decodable, HTMLStringInitable {
		public var value: Value
	}
}

public extension VK.Objects.Response {
	init(htmlString html: String) throws {
		let html = html.replacingOccurrences(of: "<!--", with: "")
		value = try VDJSONDecoder().decode(Value.self, from: Data(html.utf8))
	}
}

extension VK.Objects.Response: Encodable where Value: Encodable {}
