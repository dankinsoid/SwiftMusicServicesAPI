import Foundation
import SwiftAPIClient

public enum SPContentType: String, Codable, CaseIterable {
	case album, artist, playlist, track, show, episode, unknown

	public init(from decoder: Decoder) throws {
		self = try Self(rawValue: String(from: decoder)) ?? .unknown
	}
}

extension SPContentType: Mockable {
	public static let mock = SPContentType.track
}
