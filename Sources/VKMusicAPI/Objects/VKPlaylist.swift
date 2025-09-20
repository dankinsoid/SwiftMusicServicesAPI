import Foundation
import SwiftAPIClient

public struct VKPlaylist: Codable, Identifiable, Hashable {
	public let id: Int
	public var owner: Int
	public var name: String
	public var artist: String?
	public var imageURL: URL?
	public var tracks: [VKAudio]?
	public var hash: String
	public var editHash: String?
}

extension VKPlaylist: Mockable {
	public static let mock = VKPlaylist(
		id: 123_456,
		owner: 789_012,
		name: "Mock VK Playlist",
		artist: "Mock Artist",
		imageURL: URL(string: "https://vk.com/images/mock_playlist.jpg"),
		tracks: [VKAudio.mock],
		hash: "mock_hash_12345",
		editHash: "mock_edit_hash_67890"
	)
}
