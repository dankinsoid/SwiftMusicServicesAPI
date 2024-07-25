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
            media: SoundCloud.Objects.Media? = nil
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
        }
        public var urn: String { "soundcloud:tracks:\(id)" }
    
        public var duration: Double? {
            (transcoding?.duration).flatMap { $0 / 1000 }
        }
        public var streamURL: URL? {
            transcoding?.url
        }

        public var transcoding: SoundCloud.Objects.TransCoding? {
            guard let transcodings = media?.transcodings else { return nil }
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
    
            public init(protocol: `Protocol`? = nil) {
                self.protocol = `protocol`
            }

            public struct `Protocol`: StringWrapper {
                
                public var description: String
                public init(_ value: String) { self.description = value }
                
                public static let progressive = Self("progressive")
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
