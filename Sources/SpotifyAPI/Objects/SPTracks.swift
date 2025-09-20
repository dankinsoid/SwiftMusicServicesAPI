import Foundation
import SwiftAPIClient

public struct SPTracks: Codable {
	public var href: String
	public var total: Int

	public init(href: String, total: Int) {
		self.href = href
		self.total = total
	}
}

extension SPTracks: Mockable {
	public static let mock = SPTracks(
		href: "https://api.spotify.com/v1/albums/mock_id_123/tracks",
		total: 10
	)
}
