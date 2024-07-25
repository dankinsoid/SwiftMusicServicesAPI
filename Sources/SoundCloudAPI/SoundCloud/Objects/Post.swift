import Foundation

extension SoundCloud.Objects {
    
    public struct Post: Identifiable, Equatable, Codable {
        
        public enum Kind: Equatable {
            case track(Track)
            case trackRepost(Track)
            case playlist(Playlist)
            case playlistRepost(Playlist)
        }
        
        public enum Item: Equatable {
            case track(Track)
            case playlist(Playlist)
        }

        public var id: String
        public var date: Date
        public var caption: String?
        public var kind: Kind
        public var user: User
        
        public var isRepost: Bool {
            switch kind {
            case .trackRepost(_): return true
            case .playlistRepost(_): return true
            default: return false
            }
        }
        
        public var isTrack: Bool {
            switch kind {
            case .track(_): return true
            case .trackRepost(_): return true
            default: return false
            }
        }
        
        public var tracks: [Track] {
            switch kind {
            case .track(let track): return [track]
            case .trackRepost(let track): return [track]
            case .playlist(let playlist): fallthrough
            case .playlistRepost(let playlist): return playlist.tracks ?? []
            }
        }
        
        public var playlist: Playlist? {
            switch kind {
            case .playlist(let playlist): return playlist
            case .playlistRepost(let playlist): return playlist
            default: return nil
            }
        }
        
        public var item: Item {
            switch kind {
            case .track(let track): return .track(track)
            case .trackRepost(let track): return .track(track)
            case .playlist(let playlist): return .playlist(playlist)
            case .playlistRepost(let playlist): return .playlist(playlist)
            }
        }
        
        
        enum CodingKeys: String, CodingKey {
            case id = "uuid"
            case date = "created_at"
            case caption
            case type
            case track
            case playlist
            case user
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(String.self, forKey: .id)
            date = try container.decode(Date.self, forKey: .date)
            caption = try container.decodeIfPresent(String.self, forKey:.caption)
            
            user = try container.decode(User.self, forKey: .user)
            let type = try container.decode(String.self, forKey: .type)
            switch type {
            case "track":
                let track = try container.decode(Track.self, forKey: .track)
                kind = .track(track)
            case "track-repost":
                let track = try container.decode(Track.self, forKey: .track)
                kind = .trackRepost(track)
            case "playlist":
                let playlist = try container.decode(Playlist.self, forKey: .playlist)
                kind = .playlist(playlist)
            case "playlist-repost":
                let playlist = try container.decode(Playlist.self, forKey: .playlist)
                kind = .playlistRepost(playlist)
            default:
                throw UndefinedPostTypeError(type: type)
            }
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            try container.encode(id, forKey: .id)
            try container.encode(date, forKey: .date)
            try container.encode(caption, forKey: .caption)
            try container.encode(caption, forKey: .caption)
            try container.encode(user, forKey: .user)
            
            switch kind {
            case .track(let track):
                try container.encode("track", forKey: .type)
                try container.encode(track, forKey: .track)
            case .trackRepost(let track):
                try container.encode("track-repost", forKey: .type)
                try container.encode(track, forKey: .track)
            case .playlist(let playlist):
                try container.encode("playlist", forKey: .type)
                try container.encode(playlist, forKey: .playlist)
            case .playlistRepost(let playlist):
                try container.encode("playlist-repost", forKey: .type)
                try container.encode(playlist, forKey: .playlist)
            }
        }
    }
}

public struct UndefinedPostTypeError: Error {
    
    public var type: String
}
