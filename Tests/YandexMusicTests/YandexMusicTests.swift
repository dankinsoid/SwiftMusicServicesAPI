import Foundation
import SwiftHttp
import VDCodable
import XCTest
import YandexMusicAPI

final class YandexMusicTests: XCTestCase {

    let api = YM.API(
        client: UrlSessionHttpClient(logLevel: .info),
        token: "y0_AgAAAAACl168AAG8XgAAAADiuaz_z9jbEVQOQguPkYrLkSg90-khb_U"
    )

    func testUser() async throws {
        let account = try await api.account()
        dump(account)
    }

    func testPlaylists() async throws {
        let account = try await api.account()
        print(account.account.uid)
        let list = try await api.playlistsList(userID: account.account.uid)
        print(list.count)
        let playlist = try await api.playlists(userID: account.account.uid, playlistsKinds: [list[0].kind])[0]
        dump(playlist)
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
        dump(result.tracks?.results.first?.short)
    }
    
    func testAdd() async throws {
        let result = try await api.search(text: "Isabella Dances", page: 0)
        guard let toAdd = result.tracks?.results.first?.short else {
            throw HttpError.invalidResponse
        }
        let tracks = try await api.playlistsAdd(
            userID: 43474620,
            playlistKind: 1244,
            revision: 3,
            tracks: [toAdd]
        )
        print(tracks)
    }
}
