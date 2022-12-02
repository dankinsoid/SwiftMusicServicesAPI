import Foundation

public struct SPSavedTrack: Codable {
	/// The date and time the track was saved.
	public var addedAt: Date?
	/// Information about the track.
	public var track: SPTrack

	public init(addedAt: Date? = nil, track: SPTrack) {
		self.addedAt = addedAt
		self.track = track
	}
}
