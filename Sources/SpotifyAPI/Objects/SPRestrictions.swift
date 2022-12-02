import Foundation

public struct SPRestrictions: Codable {
	public var reason: String

	public init(reason: String) {
		self.reason = reason
	}
}
