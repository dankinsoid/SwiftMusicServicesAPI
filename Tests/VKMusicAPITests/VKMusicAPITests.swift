import Foundation
import SwiftHttp
import VKMusicAPI
import XCTest

final class VKMusicAPITests: XCTestCase {

	let api = VK.API(
		client: UrlSessionHttpClient(logLevel: .info),
        webCookies: [
            "remixsid":"1_MRjkOy4xYx8nnecEWXOo396fX4eoPl8S3K26XCrOgYW4HZdgQXiQ1G30uoqjnZip3vKookk0UjNZk6TNZ0Mjng",
            "remixnsid":"vk1.a.RdlTH-yPCBtTvX0AL4Vp_hExBnV5n7vHzQ-JI5BDv0XgBsdhU75qej1GDPE3Cdbu3EopobY1V4Z9dDfHyhhkHDz6KRi718gMZK6OhNaIJFqFLoptAvEk_WOrJkT0Jrwsg6Hm_57jjDML8EMHiYoRA-PCoo_sG43k4I49FAw2NMiurjWEdK2ePUrgpwSyz-3s"
        ]
	)

	func testList() async throws {
		let list = try await api.list(id: "73750576")
		print(list.count)
	}
	
	func testPlaylistsById() async throws {
		let page: VK.API.AudioFirstPageRequestOutput = try await api.request(url: api.baseURL.path("audios73750576"))
		print(page.tracks.count)
	
//		let list = try await api.playlists(id: "73750576")
//		print("Count: \(list.count)")
	}

	func testUser() async throws {
		let user = try await api.checkAuthorize()
		guard let id = user.user?.id else {
			XCTFail("nonuathorized")
			return
		}
		let plists = try await api.myPlaylists(id: "\(id)")
		let tr = try await api.audioPageRequest(act: plists[0].act ?? "", offset: 0)
		print(tr)
		let plist = try await api.list(playlist: plists[0])
		print(plist.count)
	}
}
