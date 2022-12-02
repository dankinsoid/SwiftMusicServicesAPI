import Foundation

public enum SPDisallows: String, Codable, CaseIterable {
	case interrupting_playback
	case pausing
	case resuming
	case seeking
	case skipping_next
	case skipping_prev
	case toggling_repeat_context
	case toggling_shuffle
	case toggling_repeat_track
	case transferring_playback
}
