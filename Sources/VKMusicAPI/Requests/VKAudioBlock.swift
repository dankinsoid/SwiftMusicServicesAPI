import Foundation
import SimpleCoders
import SwiftSoup

public extension VK.API {
	func audioBlock() async throws -> AudioBlock {
        try await client("audio")
            .xmlHttpRequest
            .call(.http, as: .htmlInitable)
	}

	struct AudioBlock {
		public var href: String
		public var block: String
	}
}

extension VK.API.AudioBlock: HTMLStringInitable {

	public init(htmlString html: String) throws {
		let regex = #"href=\\?"\\?(\/audio\?[a-z_=?A-Z0-9&%]*block[^\\"]+)"#
		guard let href = html.firstGroup(of: regex) else {
			throw DecodingError.keyNotFound(
				SimpleCoders.PlainCodingKey("href"),
				DecodingError.Context(codingPath: [], debugDescription: html, underlyingError: nil)
			)
		}
		self.href = href
		guard let block = href.firstGroup(of: "block=([^&]+)") else {
			throw DecodingError.keyNotFound(SimpleCoders.PlainCodingKey("block"), DecodingError.Context(codingPath: [], debugDescription: html, underlyingError: nil))
		}
		self.block = block
	}
}
