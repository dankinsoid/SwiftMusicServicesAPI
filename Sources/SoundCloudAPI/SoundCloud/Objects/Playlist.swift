import Foundation

extension SoundCloud.Objects {

    public struct Playlist: Equatable, Identifiable, Codable {

        public var id: String
        public var urn: String?
        public var title: String
        public var description: String?
        public var artworkURL: URL?
        public var permalinkURL: URL?
        public var isPublic: Bool?
        public var user: SoundCloud.Objects.User?

        public var tracks: [SoundCloud.Objects.Track]?

        public var madeForUser: SoundCloud.Objects.User?
        public var secretToken: String?
        public var isAlbum: Bool?
        public var date: Date?
        
        enum CodingKeys: String, CodingKey {
    
            case id
            case title
            case urn
            case description
            case artworkURL = "artwork_url"
            case permalinkURL = "permalink_url"
            case isPublic = "public"
            case isPublic2 = "is_public"
            case tracks
            case user
            case secretToken = "secret_token"
            case isAlbum = "is_album"
            case date = "created_at"
            case madeForUser = "made_for"
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
    
            do {
                let intID = try container.decode(Int.self, forKey: .id)
                id = String(intID)
            } catch {
                id = try container.decode(String.self, forKey: .id)
            }
    
            urn = try container.decodeIfPresent(String.self, forKey: .urn)
            title = try container.decode(String.self, forKey: .title)
            description = try container.decodeIfPresent(String.self, forKey: .description)
            artworkURL = try container.decodeIfPresent(URL.self, forKey: .artworkURL)
            permalinkURL = try container.decodeIfPresent(URL.self, forKey: .permalinkURL)
            
            let rawIsPublic = try container.decodeIfPresent(Bool.self, forKey: .isPublic)
            let rawIsPublic2 = try container.decodeIfPresent(Bool.self, forKey: .isPublic2)
            isPublic = rawIsPublic ?? rawIsPublic2
    
            user = try container.decodeIfPresent(SoundCloud.Objects.User.self, forKey: .user)
            madeForUser = try container.decodeIfPresent(SoundCloud.Objects.User.self, forKey: .madeForUser)
            tracks = try container.decodeIfPresent([SoundCloud.Objects.Track].self, forKey: .tracks)
            isAlbum = try container.decodeIfPresent(Bool.self, forKey: .isAlbum)
            secretToken = try container.decodeIfPresent(String.self, forKey: .secretToken)
            date = try container.decodeIfPresent(Date.self, forKey: .date)
        }

        public func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(title, forKey: .title)
            try container.encodeIfPresent(urn, forKey: .urn)
            try container.encodeIfPresent(description, forKey: .description)
            try container.encodeIfPresent(artworkURL, forKey: .artworkURL)
            try container.encodeIfPresent(permalinkURL, forKey: .permalinkURL)
            try container.encodeIfPresent(isPublic, forKey: .isPublic)
            try container.encodeIfPresent(user, forKey: .user)
            try container.encodeIfPresent(tracks, forKey: .tracks)
            try container.encodeIfPresent(madeForUser, forKey: .madeForUser)
            try container.encodeIfPresent(secretToken, forKey: .secretToken)
            try container.encodeIfPresent(isAlbum, forKey: .isAlbum)
            try container.encodeIfPresent(date, forKey: .date)
        }
    }
}
