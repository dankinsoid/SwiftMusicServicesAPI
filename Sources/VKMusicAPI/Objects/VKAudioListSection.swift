//
//  File.swift
//  
//
//  Created by Данил Войдилов on 08.04.2022.
//

import Foundation
import VDCodable

public struct VKAudioListSection: Codable, HTMLStringInitable {
	public var list: [VKAudio]
	public var totalCount: Int
	public var editHash: String?
	public var nextOffset: String?
}

extension VKAudioListSection {
	public init(htmlString html: String) throws {
		let html = html.replacingOccurrences(of: "<!--", with: "")
		let jsc = html.components(separatedBy: "<!json>")
		if jsc.count > 1 {
			let json = jsc[1].components(separatedBy: "<!>").first ?? ""
			let _data = json.data(using: .utf8) ?? Data()
			let decoder = JSONDecoder()
			self = try decoder.decode(VKAudioListSection.self, from: _data)
		} else {
			let _data = html.data(using: .utf8) ?? Data()
			let json = try JSON(from: _data).recursiveFind(containsKey: CodingKeys.list.stringValue) ?? .null
			let decoder = VDJSONDecoder()
			self = try decoder.decode(VKAudioListSection.self, json: json)
		}
	}
}

extension JSON {
	
	func recursiveFind(containsKey key: String) -> JSON? {
		if object?[key] != nil {
			return self
		}
		for json in self {
			if let result = json.recursiveFind(containsKey: key) {
				return result
			}
		}
		return nil
	}
}
