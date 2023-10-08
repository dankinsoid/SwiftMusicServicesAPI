import Foundation

public struct VKPage: Codable {

	public var html: String

	public init(html: String) {
		self.html = html
	}
}
