@testable import AppleMusicAPI
import XCTest
import SwiftAPIClient

final class AppleMusicTests: XCTestCase {
    
    let api = AppleMusic.API(
        client: APIClient().loggingComponents([.basic, .body]),
        token: nil
    )
    
    func testGetTracks() async throws {
        let songs = try await api.mySongs(limit: 10).collect()
        print(songs.count)
    }
    
    func testSearch() async throws {
        let search = try await api.search(storefront: "AE", input: AppleMusic.API.SearchInput(term: "Swift", types: [.songs]))
        dump(search)
    }
    
    func testSearchByISRC() async throws {
        let search = try await api.songsByISRC(storefront: "AE", isrcs: ["USUM71900767"]).collect()
        dump(search)
    }
    
    func testAddPlaylist() async throws {
        let addedPlaylist = try await api.addPlaylist(
            input: AppleMusic.API.AddPlaylistInput(
                name: "Test Playlist",
                description: "This is a test playlist",
                trackIDs: ["1679036746"]
            )
        )
        .collect()
        dump(addedPlaylist)
    }
    
    func testAddTrack() async throws {
        let playlists = try await api.getMyPlaylists(limit: 1).collect()
        let search = try await api.songsByISRC(storefront: "AE", isrcs: ["USUM71900768"]).collect()
        try await api.addTracks(
            playlistID: playlists[0].id,
            tracks: AppleMusic.Objects.Response<AppleMusic.Objects.Item>(data: search)
        )
    }
}
