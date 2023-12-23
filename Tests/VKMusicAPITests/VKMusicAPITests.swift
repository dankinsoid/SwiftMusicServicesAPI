import Foundation
import SwiftHttp
import VKMusicAPI
import XCTest

final class VKMusicAPITests: XCTestCase {

	let api = VK.API(
		client: UrlSessionHttpClient(logLevel: .critical),
		webCookies: [
			"remixsid": "1_81lt26oBXmobBhk4wLNhe2kEJW9YMSHdfs9KIXGXb0vTcMkWm4shevrOiGXZBMUVy6PrWMt8d6aYgBtzlMP3bA",
			"remixnsid": "vk1.a.XsFLVfqZKpOwU6A3_gl-sWh_BuXgaWdQlXloPVwelAhGJuw3lnr2LnZSh4AMB9OXRNxfIhQ5E_q6BMBPC06skypiQWx1pY76AX-VKhDHXte2pnn3d7HvUJzS7NMPW8F7BRw8ZbKVz6MfjJWTglVyE7LUPfW0U8Cno8N6z3fuxV0JoNbVO45Onf9zek6Dir3p",
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
