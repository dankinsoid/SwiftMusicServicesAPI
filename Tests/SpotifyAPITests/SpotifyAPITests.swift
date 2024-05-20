import Foundation
import SpotifyAPI
import XCTest
import SwiftAPIClient

final class SpotifyAPITests: XCTestCase {

    let api = Spotify.API(
        client: APIClient(),
        clientID: "",
        clientSecret: ""
    )

    func testGetPlatlists() async throws {
        async let playlists = try api.playlists().collect()
        async let saved = try api.myTracks(limit: nil).collect()
        for playlist in (try await playlists) {
            try await dump(api.playlistTracks(id: playlist.id).collect())
        }
        dump(try await saved)
        dump(try await playlists)
    }
    
    func testSearch() async throws {
        async let result = try api.search(q: SPQuery([.artist: "Metallica"]), type: [.track], limit: 1)
        dump(try await result)
    }
}
