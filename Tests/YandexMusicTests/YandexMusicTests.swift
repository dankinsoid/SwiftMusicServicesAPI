import Foundation
import SwiftHttp
import VDCodable
import XCTest
import YandexMusicAPI

final class YandexMusicTests: XCTestCase {

    let api = YM.API(
        client: ProxyClient(base: UrlSessionHttpClient(session: session(), logLevel: .info)),
        token: "y0_AgAAAAACl168AAG8XgAAAAEAsHhbAABtKsyG7pBBAI-yJpqOHLSTeiLimA"
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

private struct ProxyClient: HttpClient {

    let base: HttpClient

    func dataTask(_ req: any SwiftHttp.HttpRequest) async throws -> any SwiftHttp.HttpResponse {
        try await base.dataTask(proxied(req))
    }
    
    func downloadTask(_ req: any SwiftHttp.HttpRequest) async throws -> any SwiftHttp.HttpResponse {
        try await base.downloadTask(proxied(req))
    }
    
    func uploadTask(_ req: any SwiftHttp.HttpRequest) async throws -> any SwiftHttp.HttpResponse {
        try await base.uploadTask(proxied(req))
    }
    
    private func proxied(_ req: HttpRequest) throws -> HttpRequest {
        let username = "VK6EFPcD07"
        let password = "KXLobQ78lS"
        let userPasswordString = "\(username):\(password)"
        guard let userPasswordData = userPasswordString.data(using: .utf8) else {
            throw InvalidResponse()
        }
        let base64EncodedCredential = userPasswordData.base64EncodedString()
        var request = HttpRawRequest(url: req.url, method: req.method, headers: req.headers, body: req.body)
        request.headers["Proxy-Authorization"] = "Basic \(base64EncodedCredential)"
        return request
    }

    private struct InvalidResponse: Error {}
}

private func session() -> URLSession {

    let proxyHost = "45.132.252.75"
    let proxyPort = 37959
    let username = "VK6EFPcD07"
    let password = "KXLobQ78lS"

    let proxyURL = URL(string: "http://\(username):\(password)@\(proxyHost):\(proxyPort)")!

    let config = URLSessionConfiguration.default
    config.connectionProxyDictionary = [
        kCFNetworkProxiesHTTPEnable as String: true,
        kCFNetworkProxiesHTTPProxy as String: proxyHost,
        kCFNetworkProxiesHTTPPort as String: proxyPort,
        kCFNetworkProxiesHTTPSEnable as String: true,
        kCFNetworkProxiesHTTPSProxy as String: proxyHost,
        kCFNetworkProxiesHTTPSPort as String: proxyPort
    ]
    return URLSession(configuration: config)
}
