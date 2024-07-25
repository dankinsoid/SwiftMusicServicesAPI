import Foundation

extension SoundCloud.Objects {
    
    public struct LibraryPlaylist: Codable {
        
        public var date: Date?
        public var playlist: SoundCloud.Objects.Playlist? { userPlaylist ?? systemPlaylist }

        private var userPlaylist: SoundCloud.Objects.Playlist?
        private var systemPlaylist: SoundCloud.Objects.Playlist?

        public init(date: Date? = nil, playlist: SoundCloud.Objects.Playlist? = nil) {
            self.date = date
            self.userPlaylist = playlist
        }

        enum CodingKeys: String, CodingKey {
            
            case date = "created_at"
            case userPlaylist = "playlist"
            case systemPlaylist = "system_playlist"
        }
    }

    public struct TrackLike: Codable {
        
        public var date: Date?
        public var track: SoundCloud.Objects.Track

        public init(date: Date? = nil, track: SoundCloud.Objects.Track) {
            self.date = date
            self.track = track
        }
        
        enum CodingKeys: String, CodingKey {
            
            case date = "created_at"
            case track
        }
    }
}
