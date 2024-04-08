import Foundation
import SwiftAPIClient

extension QQMusic.API {

    /// Get personal playlist directory.
    public func userPlaylists() async throws -> QQPlaylistsLists {
        try await client
            .query("opi_cmd", "fcg_music_custom_get_songlist_self.fcg")
            .call()
    }

    /// Create a playlist.
    public func createPlaylist(name: String) async throws -> Int {
        try await createDeleteClient(cmd: "add")
            .query("songlist_name", name)
            .call(.http, as: .decodable(DeleteResult.self))
            .diss_id
    }

    /// Delete a playlist.
    public func deletePlaylist(id: Int) async throws {
        try await createDeleteClient(cmd: "del")
            .query("diss_id", id)
            .call()
    }
    
    /// Get the list of songs in the playlist.
    ///
    /// - Parameters:
    ///  - id: Playlist ID. If the login state is valid, id=0 is supported to obtain the content of the user's "I Like Playlist"
    ///  - page: Page number, starting from 0
    ///  - pageSize: Number of songs per page. Maximum 30.
    public func playlistSongs(
        id: Int,
        page: Int = 0,
        pageSize: Int = 30
    ) async throws -> QQPlaylist {
        try await client
            .query("opi_cmd", "fcg_music_custom_get_songlist_detail.fcg")
            .query("dissid", id)
            .call()
    }
}

extension QQStatusCode {

    /// Failed to obtain my favorite playlist data
    public static let failedToObtainMyFavoritePlaylistData: QQStatusCode = 100402
    /// Failed to obtain custom playlist data
    public static let failedToObtainCustomPlaylistData: QQStatusCode = 100403

    /// Failed to create playlist
    public static let failedToCreatePlaylist: QQStatusCode = 102600
    /// Failed to delete playlist
    public static let failedToDeletePlaylist: QQStatusCode = 102601
    /// Parameter error
    public static let parameterError: QQStatusCode = 102602
    
    /// Illegal playlist ID parameter
    public static let illegalPlaylistIDParameter: QQStatusCode = 100426
    /// No permission to view playlist
    public static let noPermissionToViewPlaylist: QQStatusCode = 100428
    /// Illegal page number or page count parameter
    public static let illegalPageNumberOrPageCountParameter: QQStatusCode = 100430
    ///  Failed to obtain the song list (usually caused by the dissid corresponding to the playlist not existing in the parameters passed in. It may have been transmitted incorrectly or the playlist owner deleted it.）
    public static let failedToObtainTheSongList: QQStatusCode = 100431
    /// Exception in getting song list
    public static let exceptionInGettingSongList: QQStatusCode = 100433
}

private extension QQMusic.API {

    func createDeleteClient(cmd: String) -> APIClient {
        client
            .query("opi_cmd", "fcg_music_custom_oper_songlist.fcg")
            .query("cmd", cmd)
    }
    
    struct DeleteResult: Decodable {
        var diss_id: Int
    }
}
