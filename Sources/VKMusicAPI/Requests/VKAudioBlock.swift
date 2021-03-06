//
// Created by Данил Войдилов on 09.04.2022.
//

import Foundation
import SwiftHttp
import SwiftSoup
import SimpleCoders

extension VK.API {

	public func audioBlock() async throws -> AudioBlock {
		try await request(
				url: baseURL.path("audio"),
				method: .get
		)
	}

	public struct AudioBlock {
		public var href: String
		public var block: String
	}
}

extension VK.API.AudioBlock: HTMLStringInitable {
	public init(htmlString html: String) throws {
			let document = try SwiftSoup.parse(html.trimmingCharacters(in: .whitespaces))
			let key = "Pad__corner al_empty"
			guard let div = try document.getElementsByClass(key).first(where: { try $0.attr("href").contains("act=block") }) else {
				throw DecodingError.keyNotFound(PlainCodingKey(key), DecodingError.Context(codingPath: [], debugDescription: "", underlyingError: nil))
			}
			href = try div.attr("href")
			block = href.components(separatedBy: "block=").dropFirst().first?.components(separatedBy: "&").first ?? ""
	}
}
