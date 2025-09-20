import Foundation
import SwiftAPIClient

public struct SPCursor: Codable {
	/// The cursor to use as key to find the next page of items.
	public var after: String

	public init(after: String) {
		self.after = after
	}
}

extension SPCursor: Mockable {
	public static let mock = SPCursor(
		after: "mock_cursor_123"
	)
}
