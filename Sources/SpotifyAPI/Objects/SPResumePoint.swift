public struct SPResumePoint: Codable {
	/// Whether or not the episode has been fully played by the user.
	public var fullyPlayed: Bool
	/// The user's most recent position in the episode in milliseconds.
	public var resumePositionMs: Int

	public init(fullyPlayed: Bool, resumePositionMs: Int) {
		self.fullyPlayed = fullyPlayed
		self.resumePositionMs = resumePositionMs
	}
}
