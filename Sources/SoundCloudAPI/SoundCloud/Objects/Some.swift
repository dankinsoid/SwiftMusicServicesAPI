import Foundation

extension SoundCloud.Objects {
    
    public enum Some: Identifiable, Equatable {

        case user(SoundCloud.Objects.User)
        case track(SoundCloud.Objects.Track)
        case userPlaylist(SoundCloud.Objects.Playlist)
        case systemPlaylist(SoundCloud.Objects.Playlist)
        
        public var id: String {
            switch self {
            case .user(let user): return user.id
            case .track(let track): return track.id.description
            case .userPlaylist(let playlist): return playlist.id
            case .systemPlaylist(let playlist): return playlist.id
            }
        }
    }
}

extension SoundCloud.Objects.Some: Codable {

    enum CodingKeys: String, CodingKey {
        case kind
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let kind = try container.decode(String.self, forKey: .kind)
        
        if kind == "user" {
            let user = try SoundCloud.Objects.User(from: decoder)
            self = .user(user)
        }
        else if kind == "track" {
            let track = try SoundCloud.Objects.Track(from: decoder)
            self = .track(track)
        }
        else if kind == "playlist" {
            let playlist = try SoundCloud.Objects.Playlist(from: decoder)
            self = .userPlaylist(playlist)
        }
        else if kind == "system-playlist" {
            let playlist = try SoundCloud.Objects.Playlist(from: decoder)
            self = .systemPlaylist(playlist)
        }
        else {
            throw UnknownKindError(kind: kind)
        }
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .user(let user):
            try container.encode("user", forKey: .kind)
            try user.encode(to: encoder)
        case .track(let track):
            try container.encode("track", forKey: .kind)
            try track.encode(to: encoder)
        case .userPlaylist(let playlist):
            try container.encode("playlist", forKey: .kind)
            try playlist.encode(to: encoder)
        case .systemPlaylist(let playlist):
            try container.encode("system-playlist", forKey: .kind)
            try playlist.encode(to: encoder)
        }
    }
}

public struct UnknownKindError: Error {
    
    var kind: String
    
}
