import Foundation
import SwiftMusicServicesApi

public extension Tidal.Objects {
	
	struct UserPlaylist: Codable, Equatable {
		
		public var type: UserPlaylistType?
		public var created: Date?
		public var playlist: Playlist
		
		public init(type: UserPlaylistType? = nil, created: Date? = nil, playlist: Playlist) {
			self.type = type
			self.created = created
			self.playlist = playlist
		}
	}
	
	struct WithETag<Value> {
		
		public var eTag: String?
		public var value: Value
		
		public init(eTag: String? = nil, value: Value) {
			self.eTag = eTag
			self.value = value
		}
	}
	
	struct Playlist: Codable, Equatable {
		
		public var uuid: String
		public var title: String
		public var numberOfTracks: Int
		public var numberOfVideos: Int?
		public var creatorID: Int?
		public var description: String?
		public var duration: Int?
		public var lastUpdated: Date?
		public var created: Date?
		public var type: PlaylistType?
		public var publicPlaylist: Bool?
		public var url: URL?
		public var image: String?
		public var popularity: Int?
		public var squareImage: String?
		//        public var promotedArtists: [String]
		public var lastItemAddedAt: Date?
		
		public init(
			uuid: String,
			title: String,
			numberOfTracks: Int,
			numberOfVideos: Int? = nil,
			creatorID: Int? = nil,
			description: String? = nil,
			duration: Int? = nil,
			lastUpdated: Date? = nil,
			created: Date? = nil,
			type: PlaylistType? = nil,
			publicPlaylist: Bool? = nil,
			url: URL? = nil,
			image: String? = nil,
			popularity: Int? = nil,
			squareImage: String? = nil,
			lastItemAddedAt: Date? = nil
		) {
			self.uuid = uuid
			self.title = title
			self.numberOfTracks = numberOfTracks
			self.numberOfVideos = numberOfVideos
			self.creatorID = creatorID
			self.description = description
			self.duration = duration
			self.lastUpdated = lastUpdated
			self.created = created
			self.type = type
			self.publicPlaylist = publicPlaylist
			self.url = url
			self.image = image
			self.popularity = popularity
			self.squareImage = squareImage
			self.lastItemAddedAt = lastItemAddedAt
		}
		
		public func squareImageUrl(size: Int = 160) -> URL? {
			guard let squareImage else { return nil }
			// Valid size: 160x160, 320x320, 480x480, 640x640, 750x750, 1080x1080
			let validSizes = [160, 320, 480, 640, 750, 1080]
			let size = validSizes.first { $0 >= size } ?? 160
			return Tidal.API.imageUrl(squareImage, width: size, height: size)
		}
		
		public func imageUrl(width: Int, height: Int) -> URL? {
			guard let image else { return squareImageUrl(size: max(width, height)) }
			// Valid sizes: 160x107, 480x320, 750x500, 1080x720
			let validWidths = [160, 480, 750, 1080]
			let validHeights = [107, 320, 500, 720]
			let validSizes = Array(zip(validWidths, validHeights))
			// Find the maximum closest valid width or height:
			let validWidthI = validWidths.firstIndex { $0 >= width } ?? 0
			let validHeightI = validHeights.firstIndex { $0 >= height } ?? 0
			let (width, height) = validSizes[max(validWidthI, validHeightI)]
			return Tidal.API.imageUrl(image, width: width, height: height)
		}
	}
	
	struct PlaylistType: Hashable, Codable, LosslessStringConvertible {
		
		public var value: String
		public var description: String { value }
		
		public static let user = PlaylistType("USER")
		
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
	
	struct UserPlaylistType: Hashable, Codable, LosslessStringConvertible {
		
		public var value: String
		public var description: String { value }
		
		public static let userCreated = UserPlaylistType("USER_CREATED")
		
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
