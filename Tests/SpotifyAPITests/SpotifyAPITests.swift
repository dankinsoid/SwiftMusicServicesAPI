import Foundation
import SpotifyAPI
import SwiftAPIClient
import XCTest

final class SpotifyAPITests: XCTestCase {

	let api = Spotify.API(
		client: APIClient(),
		clientID: "",
		clientSecret: ""
	)

	func testGetPlatlists() async throws {
		async let playlists = try api.playlists().collect()
		async let saved = try api.myTracks(limit: nil).collect()
		for playlist in try await (playlists) {
			try await dump(api.playlistTracks(id: playlist.id).collect())
		}
		try await dump(saved)
		try await dump(playlists)
	}

	func testSearch() async throws {
		async let result = try api.search(q: SPQuery([.artist: "Metallica"]), type: [.track], limit: 1)
		try await dump(result)
	}
}
