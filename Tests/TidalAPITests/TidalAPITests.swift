import Foundation
@testable import TidalAPI
import SwiftAPIClient
import XCTest

final class TidalAPITests: XCTestCase {

    var api = Tidal.API.V1(
        client: APIClient().loggingComponents(.full),
        clientID: Tidal.API.desktopClientID,
        clientSecret: "",
        redirectURI: Tidal.Auth.redirectURIDesktop,
        defaultCountryCode: "NL",
        tokens: nil
    )

    func testUsers() async throws {
        let user = api.users("198537731")
        do {
            let playlists = try await user.playlistsAndFavoritePlaylists().first()
            dump(playlists)
        } catch {
            print(error)
            throw error
        }
    }

    
    func testSearch() async throws {
        let search = try await api.tracks.isrc("USIR19902111")
        print(search)
    }

    func testCreatePlaylist() async throws {
        let playlist = try await api.users("198537731").playlists.create(title: "Test 2")
        print(playlist)
    }
}
