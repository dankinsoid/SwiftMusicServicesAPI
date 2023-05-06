import Foundation
import SwiftHttp

public extension Yandex.Music.API {
    
	func likedTracks(userID id: Int) async throws -> YMO.LibraryContainer {
		try await request(
			url: baseURL.path("users", "\(id)", "likes", "tracks"),
			method: .get
		)
	}
}
