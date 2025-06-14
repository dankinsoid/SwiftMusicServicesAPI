import Foundation
import SwiftMusicServicesApi

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
		public let tracks: [TrackShort]

		public init(uid: Int, revision: Int? = nil, tracks: [Yandex.Music.Objects.TrackShort] = []) {
			self.uid = uid
			self.revision = revision
			self.tracks = tracks
		}
        
        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: Yandex.Music.Objects.Library.CodingKeys.self)
            self.uid = try container.decode(Int.self, forKey: .uid)
            self.revision = try? container.decodeIfPresent(Int.self, forKey: .revision)
            self.tracks = try container.decodeIfPresent(SafeDecodeArray<Yandex.Music.Objects.TrackShort>.self, forKey: .tracks)?.array ?? []
        }
	}
}
