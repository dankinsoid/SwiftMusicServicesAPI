import Foundation
import SwiftAPIClient
import VKMusicAPI
import XCTest
import HTTPTypes
import VDCodable
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

final class VKMusicAPITests: XCTestCase {

	let api = VK.API(
        client: APIClient().loggingComponents(.full),
        cache: MockSecureCacheService(),
        webCookies: [:]
	)
    
	func testList() async throws {
        let tracks = try await api.list().collect()
        print(tracks.count)
	}

	func testPlaylistsById() async throws {
		let list = try await api.playlists(id: 73750576)
		print("Count: \(list.count)")
	}

	func testUser() async throws {
//        let html: String = try await api.client("account")
//            .xmlHttpRequest
//            .call()
//        print(html)
		let user = try await api.checkAuthorize()
//		guard let id = user.user?.id else {
//			XCTFail("nonuathorized")
//			return
//		}
//        print(id)
//		let plists = try await api.playlists(id: id)
//        print(plists)
	}
}
