import SwiftHttp

public extension Spotify.API {
	func next<Output: Decodable>(
		url: HttpUrl
	) async throws -> Output {
		try await decodableRequest(
			executor: client.dataTask,
			url: url,
			method: .get,
			headers: headers()
		)
	}
}
