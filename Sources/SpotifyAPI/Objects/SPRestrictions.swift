import Foundation
import SwiftAPIClient

public struct SPRestrictions: Codable, Sendable, Equatable {
	public var reason: String

	public init(reason: String) {
		self.reason = reason
	}
}

extension SPRestrictions: Mockable {
	public static let mock = SPRestrictions(
		reason: "market"
	)
}
