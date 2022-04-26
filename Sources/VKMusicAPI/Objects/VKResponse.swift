//
//  File.swift
//  
//
//  Created by Данил Войдилов on 08.04.2022.
//

import Foundation
import VDCodable

extension VK.Objects {
	
	public struct Response<Value: Decodable>: Decodable, HTMLStringInitable {
		public var value: Value
	}
}

extension VK.Objects.Response {
	public init(htmlString html: String) throws {
		let html = html.replacingOccurrences(of: "<!--", with: "")
		value = try VDJSONDecoder().decode(Value.self, from: Data(html.utf8))
	}
}

extension VK.Objects.Response: Encodable where Value: Encodable {}
