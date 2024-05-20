import Foundation
import SimpleCoders
import SwiftHttp
import SwiftSoup

public extension VK.API {
	func audioBlock(id: String? = nil) async throws -> AudioBlock {
		try await request(
			url: baseURL.path("audio\(id.map { "s\($0)" } ?? "")"),
			method: .get
		)
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
				PlainCodingKey("href"),
				DecodingError.Context(codingPath: [], debugDescription: html, underlyingError: nil)
			)
		}
		self.href = href
		guard let block = href.firstGroup(of: "block=([^&]+)") else {
			throw DecodingError.keyNotFound(PlainCodingKey("block"), DecodingError.Context(codingPath: [], debugDescription: html, underlyingError: nil))
		}
		self.block = block
	}
}
