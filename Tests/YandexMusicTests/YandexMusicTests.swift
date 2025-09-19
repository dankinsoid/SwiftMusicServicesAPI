import Foundation
import SwiftAPIClient
import VDCodable
import XCTest
import YandexMusicAPI

final class YandexMusicTests: XCTestCase {

    let api = YM.API(
        client: APIClient().loggingComponents(.full)
    )

    func testUser() async throws {
        let account = try await api.account()
        dump(account)
    }
    
    func testLikes() async throws {
        let likes = try await api.likedTracks(userID: 43474620)
			let tracks = try await api.tracks(ids: likes.library.tracks.map(\.id)).collect()
//        print(tracks[0])
    }

    func testPlaylists() async throws {
        let account = try await api.account()
        print(account.account.uid!)
        let list = try await api.playlistsList(userID: account.account.uid ?? 0)
        print(list.count)
        let playlist = try await api.playlists(userID: account.account.uid ?? 0, playlistsKinds: [list[0].kind])[0]
        dump(playlist)
        let plList = try await playlist.copy(
					tracks: api.tracks(ids: playlist.tracks.map(\.id)).collect()
        )
        let likedTracks = try await api.likedTracks(userID: account.account.uid ?? 0).library.tracks
        print(likedTracks.count)
			let likes = try await api.tracks(ids: likedTracks.map(\.id)).collect()
        print(likes.count)
    }
    
    func testSearch() async throws {
        let result = try await api.search(text: "Blindfold Derek Pope", page: 0)
        dump(result.tracks?.results.first?.short)
    }

    func testLike() async throws {
        try await api.like(trackIDs: ["46682063"], userID: 43474620)
    }
    
    func testAdd() async throws {
//        let result = try await api.search(text: "Isabella Dances", page: 0)
//        guard let toAdd = result.tracks?.results.first?.short else {
//            throw AnyError("")
//        }
        let toAdd = YMO.TrackShort(id: "46682063", albumId: 6304185)
        let tracks = try await api.playlistsAdd(
            userID: 43474620,
            playlistKind: 1253,
            revision: 16,
            tracks: [toAdd]
        )
        print(tracks)
    }
    
    func testTrackByID() async throws {
			try await dump(api.tracks(ids: ["f3b136c0-5f33-4cd5-8db1-48dc41465d5f", "81897915"]).collect())
    }
}
//
//private struct ProxyClient: HttpClient {
//
//    let base: HttpClient
//
//    func dataTask(_ req: any SwiftHttp.HttpRequest) async throws -> any SwiftHttp.HttpResponse {
//        try await base.dataTask(proxied(req))
//    }
//    
//    func downloadTask(_ req: any SwiftHttp.HttpRequest) async throws -> any SwiftHttp.HttpResponse {
//        try await base.downloadTask(proxied(req))
//    }
//    
//    func uploadTask(_ req: any SwiftHttp.HttpRequest) async throws -> any SwiftHttp.HttpResponse {
//        try await base.uploadTask(proxied(req))
//    }
//    
//    private func proxied(_ req: HttpRequest) throws -> HttpRequest {
//        let username = "VK6EFPcD07"
//        let password = "KXLobQ78lS"
//        let userPasswordString = "\(username):\(password)"
//        guard let userPasswordData = userPasswordString.data(using: .utf8) else {
//            throw InvalidResponse()
//        }
//        let base64EncodedCredential = userPasswordData.base64EncodedString()
//        var request = HttpRawRequest(url: req.url, method: req.method, headers: req.headers, body: req.body)
//        request.headers["Proxy-Authorization"] = "Basic \(base64EncodedCredential)"
//        return request
//    }
//
//    private struct InvalidResponse: Error {}
//}
//
//private func session() -> URLSession {
//
//    let proxyHost = "45.132.252.75"
//    let proxyPort = 37959
//    let username = "VK6EFPcD07"
//    let password = "KXLobQ78lS"
//
//    let proxyURL = URL(string: "http://\(username):\(password)@\(proxyHost):\(proxyPort)")!
//
//    let config = URLSessionConfiguration.default
//    config.connectionProxyDictionary = [
//        kCFNetworkProxiesHTTPEnable as String: true,
//        kCFNetworkProxiesHTTPProxy as String: proxyHost,
//        kCFNetworkProxiesHTTPPort as String: proxyPort,
//        kCFNetworkProxiesHTTPSEnable as String: true,
//        kCFNetworkProxiesHTTPSProxy as String: proxyHost,
//        kCFNetworkProxiesHTTPSPort as String: proxyPort
//    ]
//    return URLSession(configuration: config)
//}
