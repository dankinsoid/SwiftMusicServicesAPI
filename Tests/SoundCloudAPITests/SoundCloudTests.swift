@testable import SoundCloudAPI
import XCTest
import SwiftAPIClient

final class SoundCloudTests: XCTestCase {

    func testAuthURL() {
        print(SoundCloud.OAuth2(
            clientID: SoundCloud.API.mobileWebClientID,
            redirectURI: SoundCloud.OAuth2.mobileWebRedirectURI
        ).authURL(
            state: "eyJub25jZSI6IjFDX0ttVUdGMW90bmw1VnhLN1V0aUdXekxfQWVkWHBsUDhNVElsMWdVRkVHfkNseTV0Sl9ULmN0cENqMFZmdzYiLCJjbGllbnRfaWQiOiJLS3pKeG13MTF0WXBDczZUMjRQNHVVWWhxbWphbEc2TSIsImFwcCI6IndlYi1hdXRoIiwib3JpZ2luIjoiaHR0cHM6Ly9tLnNvdW5kY2xvdWQuY29tIn0=",
            codeChallengeMethod: .S256
        ))
    }
}
