import SwiftHttp

public extension Spotify.API {
	/// https://developer.spotify.com/documentation/web-api/reference/playlists/get-a-list-of-current-users-playlists/
	func me() async throws -> SPUserPrivate {
		try await decodableRequest(executor: client.dataTask, url: baseURL.path("me"), method: .get, headers: headers())
	}
}
