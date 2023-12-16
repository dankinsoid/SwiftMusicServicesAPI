import Foundation
import SpotifyAPI
import XCTest
import SwiftHttp

final class SpotifyAPITests: XCTestCase {
    
    let api = Spotify.API(
        client: UrlSessionHttpClient(logLevel: .info),
        clientID: "",
        clientSecret: ""
    )
    
    func testAdd() async throws {
        async let playlists = try api.playlists().collect()
        async let saved = try api.myTracks(limit: nil).collect()
        for playlist in (try await playlists) {
            try await dump(api.playlistTracks(id: playlist.id).collect())
        }
        dump(try await saved)
        dump(try await playlists)
    }
}
