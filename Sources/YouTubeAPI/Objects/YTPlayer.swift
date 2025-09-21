import Foundation
import SwiftAPIClient

public extension YouTube.Objects {

	struct Player: Codable, Hashable {
		public var embedHtml: String
		public var embedHeight: Int?
		public var embedWidth: Int?

		public init(embedHtml: String) {
			self.embedHtml = embedHtml
		}
	}
}

extension YouTube.Objects.Player: Mockable {
	public static let mock = YouTube.Objects.Player(
		embedHtml: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/mock_video_id\" frameborder=\"0\" allowfullscreen></iframe>"
	)
}
