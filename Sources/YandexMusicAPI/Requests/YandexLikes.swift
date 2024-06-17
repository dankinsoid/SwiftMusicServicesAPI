import Foundation
import SwiftAPIClient

public extension Yandex.Music.API {

	func likedTracks(userID id: Int) async throws -> YMO.LibraryContainer {
        try await client("users", "\(id)", "likes", "tracks").get()
	}

    func like(trackIDs: [String], userID id: Int) async throws {
        try await client("users", "\(id)", "likes", "tracks", "add-multiple")
            .body(["track-ids": trackIDs])
            .bodyEncoder(.formURL)
            .post()
    }
}
