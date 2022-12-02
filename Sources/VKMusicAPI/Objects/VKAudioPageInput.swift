import Foundation

public struct VKAudioPageInput: Codable {
	public var section: Section?
	public var block: Block?
	public var z: String?

	public enum Section: String, Codable, CaseIterable {
		case my, all
	}

	public enum Block: String, Codable, CaseIterable {
		case my_playlists
	}
}
