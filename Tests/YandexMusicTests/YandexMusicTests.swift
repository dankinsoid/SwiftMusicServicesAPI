import Foundation
import YandexMusicAPI
import XCTest
import SwiftHttp

final class YandexMusicTests: XCTestCase {
    
    let api = YM.API(
        client: UrlSessionHttpClient(logLevel: .info)
    )
    
    func testUser() async throws {
        let account = try await api.account()
        dump(account)
    }
    
    func testPlaylists() async throws {
        let account = try await api.account()
        let list = try await api.playlistsList(userID: account.account.uid)
        print(list.count)
        let playlist = try await api.playlists(userID: account.account.uid, playlistsKinds: [list[0].kind])[0]
        print(playlist.tracks?.count ?? 0)
        let plList = try await playlist.copy(
            tracks: api.tracks(ids: (playlist.tracks?.map(\.id) ?? []))
        )
        let likedTracks = try await api.likedTracks(userID: account.account.uid).library.tracks ?? []
        print(likedTracks.count)
        let likes = try await api.tracks(ids: likedTracks.map(\.id))
        print(likes.count)
    }
    
    func testSearch() async throws {
        let result = try await api.search(text: "Blindfold Derek Pope", page: 0)
        dump(result)
    }
}
