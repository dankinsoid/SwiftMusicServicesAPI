import Foundation
import SwiftAPIClient

public struct VKUser: Codable, Equatable, Identifiable, Hashable {
	public let id: Int
}

extension VKUser: Mockable {
	public static let mock = VKUser(
		id: 123_456_789
	)
}
