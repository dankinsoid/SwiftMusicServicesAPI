import Foundation

public extension SoundCloud.Objects {

	struct Recommendation: Equatable, Codable {

		public var user: User

		public init(user: User) {
			self.user = user
		}
	}
}
