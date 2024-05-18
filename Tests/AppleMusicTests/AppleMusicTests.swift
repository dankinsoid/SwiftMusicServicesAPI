@testable import AppleMusicAPI
import XCTest
import SwiftAPIClient
import AsyncHTTPClient
import NIOHTTP1
import NIOCore

final class AppleMusicTests: XCTestCase {
    
    let api = AppleMusic.API(
        client: APIClient()
					.loggingComponents([.basic, .body])
					.httpClient(.asyncHTTPClient()),
        token: AppleMusic.Objects.Tokens(
						token: "eyJhbGciOiJFUzI1NiIsImtpZCI6IkNLMzVRVVk1NEIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiI0NzMzVDU2VVpXIiwiaWF0IjoxNzE1OTcxNzA4LjgxNDIxMywiZXhwIjoxNzIzODYwMjA4LjgxNDIxNH0.mbQWQ0v2iqyyRHAbsyOAko1pZlDq4-NRCwa3Ze07-7epHkUFvWdbopPx_ncwoSfugZln4CWf0iCSi8_qnglCdQ",
						userToken: "AsocJhf+wMjlaWpJ1Pzuht0qphFb6z4SQOQVN3haVgY\\/4gctFsh5bG00h8Xq+B1xFnHeVU24IM7Ag2o\\/PTcKlVuEFRYAHgLfBc98iQcLO31y0SpnX5ZvNGQct6xAYCTVd8+1BZn3y1wMY01zU6kxF5ffAIeMHysyXs8crN071G9BLLxGrg2X8e4GkFYXYOIfUr96uURNTn\\/9XK\\/zWqDaAql1ZuzWIIL8aLkOmWwXO3mQpO0yCQ=="
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
}

public extension SwiftAPIClient.HTTPClient {
	
	static func asyncHTTPClient() -> SwiftAPIClient.HTTPClient {
		SwiftAPIClient.HTTPClient { request, configs in
			let client = AsyncHTTPClient.HTTPClient(eventLoopGroupProvider: .singleton)
			guard let clientRequest = request.clientRequest else {
				throw AnyError()
			}
			let response = try await client.execute(request: clientRequest).get()
			try? await client.shutdown()
			return (response.body?.data ?? Data(), response.httpResponse)
		}
	}
}

extension ByteBuffer {
	var data: Data {
		getData(at: readerIndex, length: readableBytes) ?? Data()
	}
}

private struct AnyError: Error {}

private extension HTTPRequestComponents {
	
	var clientRequest: AsyncHTTPClient.HTTPClient.Request? {
		guard let url else { return nil }
		return try? AsyncHTTPClient.HTTPClient.Request(
			url: URLComponents(url: url, resolvingAgainstBaseURL: true)?.url ?? url,
			method: HTTPMethod(rawValue: method.rawValue.uppercased()),
			headers: HTTPHeaders(headers.map { ($0.name.rawName, $0.value) }),
			body: body?.data.map { .byteBuffer(ByteBuffer(data: $0)) }
		)
	}
}

extension AsyncHTTPClient.HTTPClient.Response {
	
	var httpResponse: HTTPResponse {
		var fields = HTTPFields()
		fields.append(
			contentsOf: headers.compactMap { header in
				HTTPField.Name(header.name).map {
					HTTPField(name: $0, value: header.value)
				}
			}
		)
		return HTTPResponse(
			status: HTTPResponse.Status(
				code: Int(status.code),
				reasonPhrase: status.reasonPhrase
			),
			headerFields: fields
		)
	}
}
