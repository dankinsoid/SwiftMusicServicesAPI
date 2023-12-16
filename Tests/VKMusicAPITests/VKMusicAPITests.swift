import Foundation
import SwiftHttp
import VKMusicAPI
import XCTest

final class VKMusicAPITests: XCTestCase {

	let api = VK.API(
		client: UrlSessionHttpClient(logLevel: .trace),
        webCookies: [:]
	)

	func testList() async throws {
		let list = try await api.list()
		print(list.count)
	}

	func testUser() async throws {
		let user = try await api.checkAuthorize()
		guard let id = user.user?.id else {
			XCTFail("nonuathorized")
			return
		}
		let plists = try await api.playlists(id: id)
		let tr = try await api.audioPageRequest(act: plists[0].act ?? "", offset: 0)
		print(tr)
		let plist = try await api.list(playlist: plists[0])
		print(plist.count)
	}
}
