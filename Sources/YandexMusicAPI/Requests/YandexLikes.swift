import Foundation
import SwiftAPIClient

public extension Yandex.Music.API {

	func likedTracks(userID id: Int) async throws -> YMO.LibraryContainer {
        try await client("users", "\(id)", "likes", "tracks").get()
	}
}
