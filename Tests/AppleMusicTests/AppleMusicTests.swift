@testable import AppleMusicAPI
import XCTest
import SwiftAPIClient

final class AppleMusicTests: XCTestCase {

    let api = AppleMusic.API(
        client: APIClient().loggingComponents([.full]),
        token: AppleMusic.Objects.Tokens(
            token: "eyJhbGciOiJFUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IkE2N1ozMlBYRkIifQ.eyJpc3MiOiI0NzMzVDU2VVpXIiwiaWF0IjoxNzE5MDU1Mjc1LjA0OTI4NSwiZXhwIjoxNzI2OTQzNzc1LjA0OTI4Nn0.hD1hstq4VXtCF6ls34Z4omvMuwqtm6RJc-ID5FC2JRPSpD2gzfYyHLeCZjGb3ZAW92tlTVzkbIYKyUrVS48Smg",
            userToken: "Aocdivqrc2Ypg/tuBd1ZdZsxOvil/inHz6G5mOYpWBKgnTM0NyzgD14WHShSbRFTKuiMdBdAvA+HJi7yPHsVU1z+wp1+w/TOdylkLy4lCcaH5dIy/yEAqI9p5LBWjTa4bMfNQwXxTvZbbUS/uDqFfe8Q/d1wjiBluiK402Z7/Tssz+yfY+W+aJey+M5A4robkA0644YYcET7KLSievimXU2NfQMuARDyxbHS9cQlHGHBN+5nkg=="
        )
    )

    func testGetTracks() async throws {
        let songs = try await api.mySongs(limit: 10).collect()
        print(songs.count)
    }

    func testSearch() async throws {
        let search = try await api.search(storefront: "AE", input: AppleMusic.API.SearchInput(term: "Swift", types: [.songs]))
        dump(search)
    }

    func testSearchByISRC() async throws {
        let search = try await api.songsByISRC(storefront: "AE", isrcs: ["USUM71900767"]).collect()
        dump(search)
    }

    func testAddPlaylist() async throws {
        let addedPlaylist = try await api.addPlaylist(
            input: AppleMusic.API.AddPlaylistInput(
                name: "Test Playlist",
                description: "This is a test playlist",
                trackIDs: ["1679036746"]
            )
        )
        .collect()
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
//public extension SwiftAPIClient.HTTPClient {
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
//}
//
//extension ByteBuffer {
//	var data: Data {
//		getData(at: readerIndex, length: readableBytes) ?? Data()
//	}
//}
//
//private struct AnyError: Error {}
//
//private extension HTTPRequestComponents {
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
//}
//
//extension AsyncHTTPClient.HTTPClient.Response {
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
//}
