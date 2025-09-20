@testable import AppleMusicAPI
import SwiftAPIClient
import XCTest

final class AppleMusicTests: XCTestCase {

	let api = AppleMusic.API(
		client: APIClient().loggingComponents([.full]).usingMocks(policy: .ignore),
		storage: MockSecureCacheService(
			[:]
		)
	)

	func testGetTracks() async throws {
//		let songs = try await api.search(storefront: "us", query: "Imagine Dragons", types: [.albums], limit: 5)
		do {
			try await api.addToFavorites(.songs, ids: ["1440815305"])
		} catch {
			print(error)
		}
//		print(songs.map(\.id))
//		try await api.add(.albums, ids: ["1445867303", "1440831203"])
	}

	func testSearch() async throws {
		let front = try await api.storefront()
//			let suggestions = try await api.suggestions(storefront: front.id, query: "Marino Devil in Disguise")
//			print(suggestions)

//			let artists = try await api.search(storefront: front.id, query: "Marino", types: [.artists], limit: 5)
		let songs = try await api.search(storefront: "us", query: "Devil in Disguise", types: [.songs], limit: 5)
		let result = try await api.equivalent(of: songs[0].id, for: front.id)
		print(result)
//			print(artists.map { ($0.attributes!.name!, $0.id) })
		print(songs.map { ($0.attributes!.artistName!, $0.attributes!.name!) })
	}

	func testSearchByISRC() async throws {
		let search1 = try await api.songsByISRC(storefront: "ge", isrcs: ["DEE351611966", "GBK3W1800834", "SE5Q51700408", "QMUY41500182", "USKFE1620002", "USA2P2114194", "GBUM71030649", "USUM71900769", "AU4T31400115", "USBQU1700033", "FRUM71402811", "USA2P2125225", "RUA1D1716180", "QZ85M1950370", "JPVI09809370", "QM24S2102446", "AU4T31400116", "USUM71707478", "TCABN1368396", "RUA1H2083663", "GBUM71601816", "GBBKS1200164", "USDPK1900094", "DEXC82300032", "TCADT1883474"]).collect()
		dump(search1)
	}

	func testAddPlaylist() async throws {
		let addedPlaylist = try await api.add(
			playlist: AppleMusic.API.AddPlaylistInput(
				name: "Test Playlist 10",
				description: "This is a test playlist",
				trackIDs: ["1679036746"]
			)
		)
		let front = try await api.storefront()
		let song = try await api.equivalent(of: "1679036746", for: "jp")
		try await api.addTracks(
			playlistID: addedPlaylist.id,
			tracks: .init(
				data: [
					AppleMusic.Objects.Item(
						attributes: nil,
						relationships: nil,
						id: song.id,
						type: .songs,
						href: nil
					),
				],
				next: nil
			)
		)
		dump(addedPlaylist)
	}

	func testAddTrack() async throws {
		let playlists = try await api.getMyPlaylists(limit: 1).collect()
		let search = try await api.songsByISRC(storefront: "AE", isrcs: ["USUM71900768"]).collect()
		try await api.addTracks(
			playlistID: playlists[0].id,
			tracks: AppleMusic.Objects.Response<AppleMusic.Objects.Item>(data: search)
		)
	}

	func testStorefrong() async throws {
		let front = try await api.storefront()
		print(front)
	}

	func testEquivalent() async throws {
		let song = try await api.equivalent(of: "1679036746", for: "jp")
		print(song)
	}
}

//
// public extension SwiftAPIClient.HTTPClient {
//
//	static func asyncHTTPClient() -> SwiftAPIClient.HTTPClient {
//		SwiftAPIClient.HTTPClient { request, configs in
//			let client = AsyncHTTPClient.HTTPClient(eventLoopGroupProvider: .singleton)
//			guard let clientRequest = request.clientRequest else {
//				throw AnyError()
//			}
//			let response = try await client.execute(request: clientRequest).get()
//			try? await client.shutdown()
//			return (response.body?.data ?? Data(), response.httpResponse)
//		}
//	}
// }
//
// extension ByteBuffer {
//	var data: Data {
//		getData(at: readerIndex, length: readableBytes) ?? Data()
//	}
// }
//
// private struct AnyError: Error {}
//
// private extension HTTPRequestComponents {
//
//	var clientRequest: AsyncHTTPClient.HTTPClient.Request? {
//		guard let url else { return nil }
//		return try? AsyncHTTPClient.HTTPClient.Request(
//			url: URLComponents(url: url, resolvingAgainstBaseURL: true)?.url ?? url,
//			method: HTTPMethod(rawValue: method.rawValue.uppercased()),
//			headers: HTTPHeaders(headers.map { ($0.name.rawName, $0.value) }),
//			body: body?.data.map { .byteBuffer(ByteBuffer(data: $0)) }
//		)
//	}
// }
//
// extension AsyncHTTPClient.HTTPClient.Response {
//
//	var httpResponse: HTTPResponse {
//		var fields = HTTPFields()
//		fields.append(
//			contentsOf: headers.compactMap { header in
//				HTTPField.Name(header.name).map {
//					HTTPField(name: $0, value: header.value)
//				}
//			}
//		)
//		return HTTPResponse(
//			status: HTTPResponse.Status(
//				code: Int(status.code),
//				reasonPhrase: status.reasonPhrase
//			),
//			headerFields: fields
//		)
//	}
// }
