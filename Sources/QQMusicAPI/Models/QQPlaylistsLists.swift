import Foundation
import SwiftAPIClient

public struct QQPlaylistsLists: Codable, Equatable {
    
    /// Playlist collection
    public var data: [QQUserPlaylist]
    
    public init(data: [QQUserPlaylist] = []) {
        self.data = data
    }
}

public struct QQUserPlaylist: Codable, Equatable, Identifiable {

    /// Playlist modification time
    public var updateTime: Date
    /// Playlist creation time
    public var createTime: Date
    /// playlist id
    public var id: Int
    /// Song list name
    public var name: String
    /// song list cover
    public var cover: URL
    /// Number of songs in the playlist
    public var songsCount: Int
    /// Number of playlist listens
    public var listensCount: Int

    public init(
        updateTime: Date,
        createTime: Date,
        id: Int,
        name: String,
        cover: URL,
        songsCount: Int,
        listensCount: Int
    ) {
        self.updateTime = updateTime
        self.createTime = createTime
        self.id = id
        self.name = name
        self.cover = cover
        self.songsCount = songsCount
        self.listensCount = listensCount
    }

    public enum CodingKeys: String, CodingKey {

        case updateTime = "update_time"
        case createTime = "create_time"
        case id = "diss_id"
        case name = "diss_name"
        case cover = "diss_pic"
        case songsCount = "song_num"
        case listensCount = "listen_num"
    }
}

extension QQUserPlaylist: Mockable {
    
    public static let mock = QQUserPlaylist(
        updateTime: Date(timeIntervalSince1970: 1630848000),
        createTime: Date(timeIntervalSince1970: 1630844000),
        id: 1,
        name: "Favorite songs",
        cover: URL(string: "https://example.com")!,
        songsCount: 1,
        listensCount: 1
    )
}

extension QQPlaylistsLists: Mockable {
    
    public static let mock = QQPlaylistsLists(data: [.mock])
}
