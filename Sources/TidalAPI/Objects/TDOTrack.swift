import Foundation
import SwiftMusicServicesApi

public extension Tidal.Objects {
	
	struct UserTrack: Codable, Equatable {
		
		@NilIfError public var type: PlaylistItemType?
		@NilIfError public var created: Date?
		public var item: Track
		
		public init(type: PlaylistItemType? = nil, created: Date? = nil, item: Track) {
			self.type = type
			self.created = created
			self.item = item
		}
	}
	
	struct Track: Codable, Equatable, Identifiable {
		
		public var id: Int
		public var title: String
		public var duration: Double
		@NilIfError public var replayGain: Double?
		@NilIfError public var peak: Double?
		@NilIfError public var allowStreaming: Bool?
		@NilIfError public var streamReady: Bool?
		@NilIfError public var streamStartDate: Date?
		@NilIfError public var premiumStreamingOnly: Bool?
		@NilIfError public var trackNumber: Int?
		@NilIfError public var volumeNumber: Int?
		@NilIfError public var version: String?
		@NilIfError public var popularity: Int?
		@NilIfError public var copyright: String?
		@NilIfError public var url: URL?
		@NilIfError public var isrc: String?
		@NilIfError public var editable: Bool?
		@NilIfError public var explicit: Bool?
		@NilIfError public var audioQuality: String?
		@NilIfError public var audioModes: [String]?
		@NilIfError public var artist: Artist?
		@NilIfError public var artists: [Artist]?
		@NilIfError public var album: Album?
		@NilIfError public var mixes: Mixes?
		
		// Playlist item
		@NilIfError public var dateAdded: Date?
		@NilIfError public var index: Int?
		@NilIfError public var itemUuid: String?
		
		public init(
			id: Int,
			title: String,
			duration: Double,
			replayGain: Double? = nil,
			peak: Double? = nil,
			allowStreaming: Bool? = nil,
			streamReady: Bool? = nil,
			streamStartDate: Date? = nil,
			premiumStreamingOnly: Bool? = nil,
			trackNumber: Int? = nil,
			volumeNumber: Int? = nil,
			version: String? = nil,
			popularity: Int? = nil,
			copyright: String? = nil,
			url: URL? = nil,
			isrc: String? = nil,
			editable: Bool? = nil,
			explicit: Bool? = nil,
			audioQuality: String? = nil,
			audioModes: [String]? = nil,
			artist: Artist? = nil,
			artists: [Artist]? = nil,
			album: Album? = nil,
			mixes: Mixes? = nil,
			dateAdded: Date? = nil,
			index: Int? = nil,
			itemUuid: String? = nil
		) {
			self.id = id
			self.title = title
			self.duration = duration
			self.replayGain = replayGain
			self.peak = peak
			self.allowStreaming = allowStreaming
			self.streamReady = streamReady
			self.streamStartDate = streamStartDate
			self.premiumStreamingOnly = premiumStreamingOnly
			self.trackNumber = trackNumber
			self.volumeNumber = volumeNumber
			self.version = version
			self.popularity = popularity
			self.copyright = copyright
			self.url = url
			self.isrc = isrc
			self.editable = editable
			self.explicit = explicit
			self.audioQuality = audioQuality
			self.audioModes = audioModes
			self.artist = artist
			self.artists = artists
			self.album = album
			self.mixes = mixes
			self.dateAdded = dateAdded
			self.index = index
			self.itemUuid = itemUuid
		}
	}
	
	struct Artist: Codable, Equatable, Identifiable {
		
		public var id: Int
		public var name: String
		@NilIfError public var type: ArtistType?
		
		public init(id: Int, name: String, type: ArtistType? = nil) {
			self.id = id
			self.name = name
			self.type = type
		}
	}
	
	struct ArtistType: Codable, Hashable, LosslessStringConvertible {
		
		public var value: String
		public var description: String { value }
		
		public static let main = ArtistType("MAIN")
		public static let featured = ArtistType("FEATURED")
		
		public init(_ value: String) {
			self.value = value
		}
		
		public init(from decoder: any Decoder) throws {
			try self.init(String(from: decoder))
		}
		
		public func encode(to encoder: any Encoder) throws {
			try value.encode(to: encoder)
		}
	}
	
	struct Album: Codable, Equatable, Identifiable {
		
		public var id: Int
		public var title: String
		@NilIfError public var cover: String?
		@NilIfError public var videoCover: String?
		
		public init(id: Int, title: String, cover: String? = nil, videoCover: String? = nil) {
			self.id = id
			self.title = title
			self.cover = cover
			self.videoCover = videoCover
		}
		
		public func coverURL(size: Int = 160) -> URL? {
			let size = coverSize(size)
			return Tidal.API.imageUrl(cover ?? "0dfd3368-3aa1-49a3-935f-10ffb39803c0", width: size, height: size)
		}
		
		public func videoCoverURL(size: Int = 160) -> URL? {
			videoCover.flatMap {
				let size = coverSize(size)
				return Tidal.API.videoUrl($0, width: size, height: size)
			}
		}
		
		private func coverSize(_ size: Int) -> Int {
			max(8, min(128, Int(pow(2, ceil(log2(Double(size) / 10)))))) * 10
		}
	}
	
	struct MixKind: Codable, Hashable, CodingKey, LosslessStringConvertible {
		
		public var value: String
		public var description: String { value }
		public var stringValue: String { value }
		public var intValue: Int? { Int(value) }
		
		public static let trackMix = MixKind("TRACK_MIX")
		public static let masterTrackMix = MixKind("MASTER_TRACK_MIX")
		
		public init(_ value: String) {
			self.value = value
		}
		
		public init(stringValue: String) {
			self.init(stringValue)
		}
		
		public init(intValue: Int) {
			self.init("\(intValue)")
		}
		
		public init(from decoder: any Decoder) throws {
			try self.init(String(from: decoder))
		}
		
		public func encode(to encoder: any Encoder) throws {
			try value.encode(to: encoder)
		}
	}
	
	struct Mixes: ExpressibleByDictionaryLiteral, Codable, Equatable, CustomStringConvertible {
		
		public var values: [MixKind: String]
		public var description: String { values.description }
		
		public init(_ values: [MixKind : String]) {
			self.values = values
		}
		
		public init(dictionaryLiteral elements: (MixKind, String)...) {
			self.values = Dictionary(uniqueKeysWithValues: elements)
		}
		
		public init(from decoder: any Decoder) throws {
			let container = try decoder.container(keyedBy: MixKind.self)
			values = [:]
			for key in container.allKeys {
				values[key] = try container.decode(String.self, forKey: key)
			}
		}
		
		public func encode(to encoder: any Encoder) throws {
			var container = encoder.container(keyedBy: MixKind.self)
			for (key, value) in values {
				try container.encode(value, forKey: key)
			}
		}
	}
	
	struct PlaylistItemType: Hashable, Codable {
		
		public var value: String
		
		public static let track = PlaylistItemType("track")
		public static let video = PlaylistItemType("video")
		
		public init(_ value: String) {
			self.value = value
		}
		
		public init(from decoder: any Decoder) throws {
			try self.init(String(from: decoder))
		}
		
		public func encode(to encoder: any Encoder) throws {
			try value.encode(to: encoder)
		}
	}
}
