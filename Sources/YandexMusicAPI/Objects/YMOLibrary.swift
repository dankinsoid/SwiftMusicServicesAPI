import Foundation
import SwiftAPIClient
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
			uid = try container.decode(Int.self, forKey: .uid)
			revision = try? container.decodeIfPresent(Int.self, forKey: .revision)
			tracks = try container.decodeIfPresent(SafeDecodeArray<Yandex.Music.Objects.TrackShort>.self, forKey: .tracks)?.array ?? []
		}
	}
	
	struct AlbumResponse: Codable {
		public let album: YMO.Album?
		
		public init(album: YMO.Album?) {
			self.album = album
		}
	}
	
	struct ArtistResponse: Codable {
		public let artist: YMO.Artist?
		public var timestamp: Date? = nil
		
		public init(artist: YMO.Artist?, timestamp: Date? = nil) {
			self.artist = artist
			self.timestamp = timestamp
		}
	}
}

extension YMO.Library: Mockable {
	public static let mock = YMO.Library(
		uid: 123_456_789,
		revision: 1000,
		tracks: [Yandex.Music.Objects.TrackShort.mock]
	)
}

extension YMO.LibraryContainer: Mockable {
	public static let mock = YMO.LibraryContainer(
		library: YMO.Library.mock
	)
}
