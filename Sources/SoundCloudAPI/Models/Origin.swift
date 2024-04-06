import Foundation

public enum Origin: Codable, Equatable {

	case track(Track)
	case playlist(Playlist)

	public init(from decoder: Decoder) throws {
		do {
			let track = try Track(from: decoder)
			self = .track(track)
		} catch {
			let playlist = try Playlist(from: decoder)
			self = .playlist(playlist)
		}
	}

	public func encode(to encoder: Encoder) throws {
		switch self {
		case let .track(value):
			try value.encode(to: encoder)
		case let .playlist(value):
			try value.encode(to: encoder)
		}
	}
}
