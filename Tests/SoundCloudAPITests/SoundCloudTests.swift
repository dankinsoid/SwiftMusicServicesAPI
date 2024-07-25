@testable import SoundCloudAPI
import XCTest
import SwiftAPIClient
import VDCodable

final class SoundCloudTests: XCTestCase {

    let api = SoundCloud.API(
        client: APIClient().loggingComponents(.full),
        clientID: SoundCloud.API.mobileWebClientID,
        redirectURI: SoundCloud.OAuth2.mobileWebRedirectURI,
        cache: MockSecureCacheService()
    )

    func testMe() async throws {
        try await dump(api.me())
    }

    func testLibrary() async throws {
        try await dump(api.me.library().first().collection[0])
    }
    
    func testLikes() async throws {
        try await dump(api.user("108168088").trackLikes().first().collection.first?.track.streamURL)
    }
    
    func testNewPlaylists() async throws {
        try await dump(api.createPlaylist(title: "Test2", description: "Test", trackIDs: [651714164]))
    }
    
    func testSearch() async throws {
        try await dump(api.search.tracks("One Republic Everybody loves me").first())
    }
    
    func testAdd() async throws {
        try await dump(api.addTracksToPlaylist(id: "1854804666", trackIDs: [651714164]))
    }
    
    func testPlaylist() async throws {
        try await dump(api.playlist(id: "1854804666").tracks)
    }
    
    func testStreamURL() async throws {
        let track = try await api.tracks([651714164]).first().collection[0]
        try await print(api.streamURL(url: track.streamURL!))
    }

    func testWaveform() async throws {
        let track = try await api.tracks([651714164]).first().collection[0]
        try await print(api.waveform(url: track.waveformURL!))
    }
}
