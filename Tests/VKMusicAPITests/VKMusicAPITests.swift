import Foundation
import SwiftAPIClient
import VKMusicAPI
import XCTest
import HTTPTypes
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

final class VKMusicAPITests: XCTestCase {

	let api = VK.API(
        client: APIClient(),
        cache: MockSecureCacheService(),
        webCookies: [:]
	)
    
	func testList() async throws {
        let list = try await api.list().first()
        print(list.count)
	}
	
	func testPlaylistsById() async throws {
		let list = try await api.playlists(id: 73750576)
		print("Count: \(list.count)")
	}

	func testUser() async throws {
		let user = try await api.checkAuthorize()
		guard let id = user.user?.id else {
			XCTFail("nonuathorized")
			return
		}
		let plists = try await api.playlists(id: id)
		let tr = try await api.audioPageRequest(act: plists[0].act ?? "", offset: 0)
		let plist = try await api.list(playlist: plists[0]).first()
		print(plist.count)
	}
}
