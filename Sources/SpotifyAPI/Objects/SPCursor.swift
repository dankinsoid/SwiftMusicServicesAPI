import Foundation

public struct SPCursor: Codable {
	/// The cursor to use as key to find the next page of items.
	public var after: String

	public init(after: String) {
		self.after = after
	}
}
