import Foundation

public extension Tidal.Objects {

    struct UserPlaylist: Codable, Equatable {
        
        public var type: UserPlaylistType?
        public var created: Date
        public var playlist: Playlist
        
        public init(type: UserPlaylistType? = nil, created: Date, playlist: Playlist) {
            self.type = type
            self.created = created
            self.playlist = playlist
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
    }

    struct PlaylistType: Hashable, Codable {
        
        public var value: String

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

    struct UserPlaylistType: Hashable, Codable {
        
        public var value: String
        
        public static let userCreated = PlaylistType("USER_CREATED")
        
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
