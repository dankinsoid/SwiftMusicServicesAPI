import Foundation

public extension YMO {
	// MARK: - Result

	struct LibraryContainer: Codable {
		public let library: Library
	}

	// MARK: - Library

	struct Library: Codable {
		public let uid: Int
		public let revision: Int?
		public let tracks: [TrackShort]?
	}
}
