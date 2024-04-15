@testable import AppleMusicAPI
import XCTest
import SwiftAPIClient

final class AppleMusicTests: XCTestCase {
    
    let api = AppleMusic.API(
        client: APIClient().loggingComponents([.basic, .body]),
        token: AppleMusic.Objects.Tokens(
            token: "eyJhbGciOiJFUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IkNLMzVRVVk1NEIifQ.eyJpc3MiOiI0NzMzVDU2VVpXIiwiaWF0IjoxNzEzMTE4ODg0LjMxOTA5MiwiZXhwIjoxNzIxMDA3Mzg0LjMxOTA5M30.4iluYZy9mrzSNVvLNXbmwlhbsujZ6S4QjoNpLs9suVZ4ogIKXSMVF89JGBNft-FzRgW4b4otniFbkfDtnosaOw",
            userToken: "AsK+YCQnFhVQRc6Z3T8rDzlHwY09lQlNKgCLppUzep/eeQwzDB2bl83CD64TroAoouD/tAu26fnIzC3lPTXLG6XXaqWE46GtZEwIRrBsn0Vw0roIvLkGB216vaMJGpOp8iJgi0b1WC1HbyNIOB1mMM4kgePn/W6DlJlrn2rj59ylBFyudA10VRLNUX8SdjKhrleqbmFx12Ls/DnR35Kg4TMDXjlaUG5qwHe3LZGot3Tt3sdF2Q=="
        )
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
