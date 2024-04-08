import Foundation
import SwiftAPIClient

public struct QQPlaylist: Codable, Equatable, Identifiable {

    /// playlist id
    public var id: Int
    /// Whether to collect, 1: collection, 0: not collection
    public var hot: Int
    /// Playlist title
    public var title: String
    /// Playlist pictures
    public var cover: URL?
    /// Number of songs in the playlist
    public var totalCount: Int
    /// Whether the playlist is created by yourself 0: No 1: Yes
    public var ownerFlag: Int?
    /// song collection
    public var songList: [QQSong]?

    public init(
        id: Int,
        hot: Int,
        title: String,
        cover: URL? = nil,
        totalCount: Int,
        ownerFlag: Int? = nil,
        songList: [QQSong]? = nil
    ) {
        self.id = id
        self.hot = hot
        self.title = title
        self.cover = cover
        self.totalCount = totalCount
        self.ownerFlag = ownerFlag
        self.songList = songList
    }

    public enum CodingKeys: String, CodingKey {

        case id = "diss_id"
        case hot
        case title = "diss_title"
        case cover = "pic_url"
        case totalCount = "total_num"
        case ownerFlag = "owner_flag"
        case songList = "song_list"
    }
}

extension QQPlaylist: Mockable {
    
    public static let mock = QQPlaylist(
        id: 1,
        hot: 1,
        title: "My Favorite Songs",
        cover: URL(string: "https://example.com/cover.jpg"),
        totalCount: 10,
        ownerFlag: 1,
        songList: [.mock]
    )
}
