import Foundation

public struct SPTracks: Codable {
	public var href: String
	public var total: Int

	public init(href: String, total: Int) {
		self.href = href
		self.total = total
	}
}
