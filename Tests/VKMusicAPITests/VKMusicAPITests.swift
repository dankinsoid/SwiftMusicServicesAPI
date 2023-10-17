import Foundation
import SwiftHttp
import VKMusicAPI
import XCTest

final class VKMusicAPITests: XCTestCase {

	let api = VK.API(
		client: UrlSessionHttpClient(logLevel: .info),
		webCookies: [
			"remixnsid": "vk1.a.w1qA83JdcoJC_UxP0f3zo70ND9kfWKRS9f7xdwGsnAPddaPf-lAHdcA6JEVG2trqmGBWMr4e4go6SInZTHDBvib7033jTTta6_XhA-TFU6583_CjrFodLOApyWQQOfG4XtmXLy_R72MJ3MaNyJErgTtbB3YCAzl7A_isYxrsoCo1O6Eu83jSxe2cOsFjUGZP",
			"remixsid": "1_7IsLO7fqB_p5bPf7iEZcv1YkwBHKRtadHV805Av8jW7qvM95x_KD3cVngZT-3H47nUnhNViGzEMmxI6diD8wmw",
		]
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
