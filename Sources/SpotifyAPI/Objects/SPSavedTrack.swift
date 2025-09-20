import Foundation
import SwiftAPIClient

public struct SPSavedTrack: Codable, Sendable {
	/// The date and time the track was saved.
	public var addedAt: Date?
	/// Information about the track.
	public var track: SPTrack?

	public init(addedAt: Date? = nil, track: SPTrack?) {
		self.addedAt = addedAt
		self.track = track
	}
}

extension SPSavedTrack: Mockable {
	public static let mock = SPSavedTrack(
		addedAt: Date(),
		track: SPTrack.mock
	)
}
