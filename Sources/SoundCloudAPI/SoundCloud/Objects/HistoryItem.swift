import Foundation

extension SoundCloud.Objects {
    
    public struct HistoryItem: Equatable, Codable {

        public var date: Date
        public var track: SoundCloud.Objects.Track
        
        enum CodingKeys: String, CodingKey {
            case date = "played_at"
            case track
        }
        
        public init(date: Date, track: SoundCloud.Objects.Track) {
            self.date = date
            self.track = track
        }
    }
}
