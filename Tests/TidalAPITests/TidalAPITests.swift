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
}

// countryCode: Optional("NL")
// 198537731
//
//- access_token: "eyJraWQiOiJ2OU1GbFhqWSIsImFsZyI6IkVTMjU2In0.eyJ0eXBlIjoibzJfYWNjZXNzIiwidWlkIjoxOTg1Mzc3MzEsInNjb3BlIjoicl91c3Igd191c3IiLCJnVmVyIjowLCJzVmVyIjowLCJjaWQiOjc3ODUsImV4cCI6MTcyMTc2NTUxMywic2lkIjoiODYxOTdlYTctYjE4My00YmRjLTgwZTMtMWUzNmMwMmIwMWUyIiwiaXNzIjoiaHR0cHM6Ly9hdXRoLnRpZGFsLmNvbS92MSJ9.oLM9LduAls5IbOmaUgCDGAYORiMIMwUqPwZImlExXDlqBJ18eGxhcLMPUaRieptsUfZqw2o7owdm5Z1x6hJ30Q"
//- refresh_token: "eyJraWQiOiJoUzFKYTdVMCIsImFsZyI6IkVTNTEyIn0.eyJ0eXBlIjoibzJfcmVmcmVzaCIsInVpZCI6MTk4NTM3NzMxLCJzY29wZSI6InJfdXNyIHdfdXNyIiwiY2lkIjo3Nzg1LCJzVmVyIjowLCJnVmVyIjowLCJpc3MiOiJodHRwczovL2F1dGgudGlkYWwuY29tL3YxIn0.AD-39L943HFov4d8WWupyqVy1s6uUEJMvlWAvKu0JjUTUpJbhGVYO96BxWGMMGFfE6Fc9CcUXL-1xBXEcjSRPs2wAOMpebV9vjT2djILnmJhk3CE8BZvjlJBNcR-Vz8zwAL5wnPtD7YjGpE_Xn5_q2zwZpwoNACq47UAbbbfm5A5gzLa"
//- expires_in: 86400.0
