import Foundation
import SwiftAPIClient

public struct QQSong: Codable, Equatable, Identifiable {
    /// song id
    public var id: Int
    /// Song name
    public var name: String
    /// song title
    public var title: String
    /// song subtitle
    public var subtitle: String?
    /// song mid
    public var mid: String
    /// Song playing time
    public var playTime: Double
    /// Whether there are songs in the QQ music library, 0: songs outside the library, 1: songs in the library (there is no song information, it is recommended to leave it gray)
    public var userOwnRule: Int?
    /// The user has permissions for the interface. 0: Browse only; 1: Playable
    public var qqMusicFlag: Int?
    /// Whether the non-conventional song can be played 0: No (recommended to leave it gray) 1: Yes
    public var opiPlayFlag: Int?
    /// Identify song type 3, 13-songs in the library; 1, 11-hotlink songs; 21-local path songs; 111-low quality
    public var songType: Int?
    
    /// album id
    public var albumID: Int
    /// Album mid
    public var albumMid: String
    /// Album name
    public var albumName: String
    
    /// singer id
    public var singerID: Int
    /// singer mid
    public var singerMid: String
    /// Singer name
    public var singerName: String
    
    public init(
        id: Int,
        name: String,
        title: String,
        subtitle: String? = nil,
        mid: String,
        playTime: Double,
        userOwnRule: Int? = nil,
        qqMusicFlag: Int? = nil,
        opiPlayFlag: Int? = nil,
        songType: Int? = nil,
        albumID: Int,
        albumMid: String,
        albumName: String,
        singerID: Int,
        singerMid: String,
        singerName: String
    ) {
        self.id = id
        self.name = name
        self.title = title
        self.subtitle = subtitle
        self.mid = mid
        self.playTime = playTime
        self.userOwnRule = userOwnRule
        self.qqMusicFlag = qqMusicFlag
        self.opiPlayFlag = opiPlayFlag
        self.songType = songType
        self.albumID = albumID
        self.albumMid = albumMid
        self.albumName = albumName
        self.singerID = singerID
        self.singerMid = singerMid
        self.singerName = singerName
    }
    
    public enum CodingKeys: String, CodingKey {
        
        case id = "song_id"
        case name = "song_name"
        case title = "song_title"
        case subtitle = "song_subtitle"
        case mid = "song_mid"
        case playTime = "song_play_time"
        case userOwnRule = "user_own_rule"
        case qqMusicFlag = "qqmusic_flag"
        case opiPlayFlag = "opi_play_flag"
        case songType = "song_type"
        
        case albumID = "album_id"
        case albumMid = "album_mid"
        case albumName = "album_name"
        
        case singerID = "singer_id"
        case singerMid = "singer_mid"
        case singerName = "singer_name"
    }
}

extension QQSong: Mockable {
    
    public static let mock = QQSong(
        id: 1,
        name: "Name",
        title: "Title",
        mid: "mid",
        playTime: 120.0,
        userOwnRule: 1,
        qqMusicFlag: 1,
        opiPlayFlag: 1,
        songType: 1,
        albumID: 1,
        albumMid: "albumMid",
        albumName: "Album",
        singerID: 1,
        singerMid: "singerMid",
        singerName: "Singer"
    )
}
