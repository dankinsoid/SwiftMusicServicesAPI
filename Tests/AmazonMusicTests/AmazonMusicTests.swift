@testable import AmazonMusicAPI
import XCTest
import SwiftAPIClient

final class AmazonMusicTests: XCTestCase {
	
	let api = Amazon.Music.BrowserAPI(
		client: APIClient().loggingComponents([.url]),
		cache: MockSecureCacheService(),
		webCookies: [:]
	)
	
	func testHome() async throws {
		let playlists = try await api.showLibraryHome().asPlaylists
		for playlist in playlists {
			let tracks = try await api.showLibraryPlaylist(id: playlist.id).asTracks
			print(tracks)
		}
	}
}
