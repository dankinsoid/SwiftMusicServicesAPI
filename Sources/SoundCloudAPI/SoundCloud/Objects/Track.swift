import Foundation

extension SoundCloud.Objects {
    
    public struct Track: Identifiable, Equatable, Codable {
        
        public var id: Int
        public var title: String?
        public var description: String?
        public var artworkURL: URL?
        public var waveformURL: URL?
        public var permalinkURL: URL?
        public var playbackCount: Int?
        public var likeCount: Int?
        public var repostCount: Int?
        public var date: Date?
        public var user: SoundCloud.Objects.User?
        public var media: SoundCloud.Objects.Media?
        public var duration: Double?
        public var fullDuration: Double?
        public var publisherMetadata: PublisherMetadata?
        public var streamable: Bool?

        public init(
            id: Int,
            title: String?,
            description: String? = nil,
            artworkURL: URL? = nil,
            waveformURL: URL? = nil,
            permalinkURL: URL? = nil,
            playbackCount: Int? = nil,
            likeCount: Int? = nil,
            repostCount: Int? = nil,
            date: Date? = nil,
            user: SoundCloud.Objects.User? = nil,
            media: SoundCloud.Objects.Media? = nil,
            duration: Double? = nil,
            fullDuration: Double? = nil,
            publisherMetadata: PublisherMetadata? = nil,
            streamable: Bool? = nil
        ) {
            self.id = id
            self.title = title
            self.description = description
            self.artworkURL = artworkURL
            self.waveformURL = waveformURL
            self.permalinkURL = permalinkURL
            self.playbackCount = playbackCount
            self.likeCount = likeCount
            self.repostCount = repostCount
            self.date = date
            self.user = user
            self.media = media
            self.duration = duration
            self.fullDuration = fullDuration
            self.publisherMetadata = publisherMetadata
            self.streamable = streamable
        }
    
        public var urn: String { "soundcloud:tracks:\(id)" }

        public var streamURL: URL? {
            transcoding?.url
        }

        public var transcoding: SoundCloud.Objects.TransCoding? {
            guard let transcodings = media?.transcodings?.filter({ $0.format?.mime_type != .ogg }) else { return nil }
            return transcodings.first(where: { $0.format?.protocol == .progressive && $0.quality == .hq })
            ?? transcodings.first(where: { $0.format?.protocol == .progressive && $0.quality == .sq })
            ?? transcodings.first(where: { $0.quality == .hq })
            ?? transcodings.first(where: { $0.quality == .sq })
            ?? transcodings.first
        }

        enum CodingKeys: String, CodingKey {

            case id
            case title
            case description
            case artworkURL = "artwork_url"
            case waveformURL = "waveform_url"
            case permalinkURL = "permalink_url"
            case media
            case playbackCount = "playback_count"
            case likeCount = "likes_count"
            case repostCount = "reposts_count"
            case date = "created_at"
            case user
            case duration
            case fullDuration = "full_duration"
            case publisherMetadata = "publisher_metadata"
            case streamable
        }
    }
    
    public struct PublisherMetadata: Equatable, Codable, Identifiable {

        public var id: Int
        public var urn: String?
        public var artist: String?
        public var contains_music: Bool?
        public var isrc: String?
        public var album_title: String?
        public var publisher: String?
        public var upc_or_ean: String?
        public var explicit: Bool?
        public var release_title: String?
        
        public init(
            id: Int,
            urn: String? = nil,
            artist: String? = nil,
            contains_music: Bool? = nil,
            isrc: String? = nil,
            album_title: String? = nil,
            publisher: String? = nil,
            upc_or_ean: String? = nil,
            explicit: Bool? = nil,
            release_title: String? = nil
        ) {
            self.id = id
            self.urn = urn
            self.artist = artist
            self.contains_music = contains_music
            self.isrc = isrc
            self.album_title = album_title
            self.publisher = publisher
            self.upc_or_ean = upc_or_ean
            self.explicit = explicit
            self.release_title = release_title
        }
    }

    public struct Media: Equatable, Codable {

        public var transcodings: [SoundCloud.Objects.TransCoding]?

        public init(transcodings: [SoundCloud.Objects.TransCoding]? = nil) {
            self.transcodings = transcodings
        }
    }
    
    public struct TransCoding: Equatable, Codable {
        
        public var format: Format?
        public var quality: SoundCloud.Objects.Quality?
        public var url: URL?
        public var duration: Double? // milliseconds
        
        public init(
            format: Format? = nil,
            quality: SoundCloud.Objects.Quality? = nil,
            url: URL? = nil,
            duration: Double? = nil
        ) {
            self.format = format
            self.quality = quality
            self.url = url
            self.duration = duration
        }

        public struct Format: Equatable, Codable {
            
            public var `protocol`: `Protocol`?
            public var mime_type: MimeType?
    
            public init(protocol: `Protocol`? = nil, mime_type: MimeType? = nil) {
                self.protocol = `protocol`
                self.mime_type = mime_type
            }

            public struct `Protocol`: StringWrapper {
                
                public var description: String
                public init(_ value: String) { self.description = value }
                
                public static let progressive = Self("progressive")
                public static let hls = Self("hls")
            }
            
            public struct MimeType: StringWrapper {
                
                public var description: String
                public init(_ value: String) { self.description = value }
        
                public static let mpeg = Self("audio/mpeg")
                public static let ogg = Self("audio/ogg")
            }
        }
    }

    public struct Quality: StringWrapper {
        
        public var description: String
        public init(_ value: String) { self.description = value }

        public static let sq = Self("sq")
        public static let hq = Self("hq")
    }
}
