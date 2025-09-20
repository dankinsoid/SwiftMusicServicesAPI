import Foundation
import SwiftAPIClient

public extension SoundCloud.Objects {

	struct Comment: Identifiable, Codable, Equatable {

		public var id: String
		public var body: String?
		public var date: Date
		public var timestamp: TimeInterval
		public var trackID: Int
		public var user: User

		enum CodingKeys: String, CodingKey {

			case id
			case body
			case date = "created_at"
			case timestamp
			case trackID = "track_id"
			case user
		}

		public init(id: String, body: String? = nil, date: Date, timestamp: TimeInterval, trackID: Int, user: User) {
			self.id = id
			self.body = body
			self.date = date
			self.timestamp = timestamp
			self.trackID = trackID
			self.user = user
		}
	}
}

extension SoundCloud.Objects.Comment: Mockable {
	public static let mock = SoundCloud.Objects.Comment(
		id: "mock_comment_id",
		body: "This is a mock comment",
		date: Date(),
		timestamp: 30.0,
		trackID: 123_456,
		user: SoundCloud.Objects.User.mock
	)
}
