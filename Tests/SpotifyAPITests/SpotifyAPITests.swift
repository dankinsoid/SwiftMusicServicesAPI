import Foundation
import SpotifyAPI
import XCTest
import SwiftAPIClient

final class SpotifyAPITests: XCTestCase {

    let api = Spotify.API(
        client: APIClient(),
        clientID: "c2ccdbf0f6c147148624e78ffbf95889",
        clientSecret: "6d1c5f40a2054a36b3f8824c07f9a621",
        token: "BQAZdcBDC_sMVLJfGAv5htu_UNztMfE81w1SJr7Sgkyn5J6LWR5SrkO_eErABxBMCXDsM255xyKwBWLbKXqLHs21VUC4l3DBYgE3f8DKXbziCieGK8jcoNuc8XhvO1K7PwNc4TLgdLiLcmsHe8C-9l-Pp49XL5ZqZX_-Vb8enzmqeUNjNcaopTAEPu9vW-wvM5ip5JBbj_crZd1iYOZL15Bx2fD-EintBxYhbFyh3xxkSFJHnk9UE9rqD4u4lz8y23iTciPqtEJaGl4etvfjDj5nIHZyNGHvOBPEbhWvTATzEpiJnzrSv6crw7UJ9CkfKqk",
        refreshToken :"AQByNUFxTCXv7oNJwijg8Q1ZevcOuaaJjPbMfiwUAMOYzravvHsjllGMIenz13nMPJjz0GKwzfBhpuzvEH4K262BrH1onEhQKQn8kRYqsUE9APMse4AgQNNMxj0S58ZkW7U"
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
