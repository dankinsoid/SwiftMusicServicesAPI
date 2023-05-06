import Foundation

public extension YMO {
	// MARK: - Result

    struct LibraryContainer: Codable {
        
		public let library: Library
        
        public init(library: Yandex.Music.Objects.Library) {
            self.library = library
        }
	}

	// MARK: - Library

    struct Library: Codable {
        
		public let uid: Int
		public let revision: Int?
		public let tracks: [TrackShort]?
        
        public init(uid: Int, revision: Int? = nil, tracks: [Yandex.Music.Objects.TrackShort]? = nil) {
            self.uid = uid
            self.revision = revision
            self.tracks = tracks
        }
	}
}
