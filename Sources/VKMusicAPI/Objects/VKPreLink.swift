//
//  File.swift
//  
//
//  Created by Данил Войдилов on 08.04.2022.
//

import Foundation
import VDCodable

public struct PreLink: Codable, HTMLStringInitable {
	public let value: String
}

extension PreLink {
	public init(htmlString html: String) throws {
		let json = try JSON(from: Data(html.replacingOccurrences(of: "<!--", with: "").utf8))
		guard let v = json.payload.deepFind(where: { $0.string?.hasPrefix("https://vk.com/mp3/audio_api_unavailable") == true })?.string, !v.isEmpty else {
			throw Er(json: json)
		}
		value = v
	}
	
	struct Er: Error {
		let json: JSON
	}
}


extension JSON {

	func deepFind(where block: (JSON) -> Bool) -> JSON? {
		if block(self) {
			return self
		}
		switch self {
		case .array(let list):
			for json in list {
				if let result = json.deepFind(where: block) {
					return result
				}
			}
		case .object(let dict):
			for (_, json) in dict {
				if let result = json.deepFind(where: block) {
					return result
				}
			}
		default: break
		}
		return nil
	}
}
