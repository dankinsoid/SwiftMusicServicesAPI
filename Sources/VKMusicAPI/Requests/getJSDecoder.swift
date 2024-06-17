// import Foundation
// import VDCodable
//
// extension VK.API {
//
//	static func getJSDecoder(id: Int) async throws -> AudioDecoder {
//		let result = Promise<AudioDecoder>.pending()
//		DispatchQueue.global().async {
//			let html = try String(contentsOf: URL(string: "https://m.vk.com/feed")~!)
//			let comps = html.components(separatedBy: "<script src=\"")
//			guard comps.count > 1 else {
//				throw NoValue()
//			}
//			var src = try comps.dropFirst()
//				.compactMap { $0.components(separatedBy: "\"").first }
//				.first(where: { $0.contains("cmodules/mobile/common.") })~!
//			if !src.hasPrefix("http") {
//				src = "https://m.vk.com" + src
//			}
//			let url = try URL(string: src)~!
//			let js = try String(contentsOf: url)
//			let symbols = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMN0PQRSTUVWXYZO123456789"
//			let parts = js.components(separatedBy: symbols)
//			let code = try "var vk = {id: \(id)},window={wbopen: false}," +
//				parts.first~!.components(separatedBy: ",").last~! + symbols +
//				parts[safe: 1]~!
//				.components(separatedBy: ".play()||Promise.resolve()}").first~!
//				.components(separatedBy: "function")
//				.nilIfEmpty~!
//				.dropLast()
//				.joined(separator: "function")
//
//			let main = try code.components(separatedBy: "window.wbopen")
//				.first~!
//				.components(separatedBy: "function ")
//				.last~!
//				.components(separatedBy: "(").first~!
//			result.fulfill(AudioDecoder(fun: main, code: code))
//		}.catch {
//			result.reject($0)
//		}
//		return result
//	}
//
//	struct NoValue: Error {}
//
//	struct AudioDecoder: Codable {
//		let fun: String
//		let code: String
//	}
// }

// [0] = "isOfficial"
// [1] = "listens"
// [2] = "id"
// [3] = "authorLine"
// [4] = "authorName"
// [5] = "gridCovers"
// [6] = "hasMore"
// [7] = "rawDescription"
// [8] = "totalCount"
// [9] = "subTitle"
// [10] = "isFollowed"
// [11] = "authorHref"
// [12] = "infoLine1"
// [13] = "list"
// [14] = "editHash"
// [15] = "addClasses"
// [16] = "nextOffset"
// [17] = "infoLine2"
// [18] = "type"
// [19] = "description"
// [20] = "followHash"
// [21] = "totalCountHash"
// [22] = "title"
// [23] = "lastUpdated"
// [24] = "accessHash"
// [25] = "ownerId"
// [26] = "coverUrl"
