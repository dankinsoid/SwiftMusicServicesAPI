import Foundation

public struct VKAudioPageInput: Codable {
	public var section: Section?
	public var block: Block?
	public var z: String?

	public enum Section: String, Codable, CaseIterable {
		case my, all, unknown
        
        public init(from decoder: Decoder) throws {
            self = try Self(rawValue: String(from: decoder)) ?? .unknown
        }
	}

	public enum Block: String, Codable, CaseIterable {
		case my_playlists, unknown
        
        public init(from decoder: Decoder) throws {
            self = try Self(rawValue: String(from: decoder)) ?? .unknown
        }
	}
}
