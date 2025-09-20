import Foundation
import SwiftAPIClient
import VDCodable

public extension Yandex.Music.API {

	func likedTracks(userID id: Int) async throws -> YMO.LibraryContainer {
		try await client("users", "\(id)", "likes", "tracks").get()
	}
	
	func likedAlbums(userID id: Int) async throws -> [YMO.AlbumResponse] {
		try await client("users", "\(id)", "likes", "albums")
			.query("rich", true)
			.get()
	}
	
	func likedArtists(userID id: Int) async throws -> [YMO.ArtistResponse] {
		try await client("users", "\(id)", "likes", "artists")
			.query("with-timestamps", true)
			.get()
	}

	func like(trackIDs: [String], userID id: Int) async throws {
		try await client("users", "\(id)", "likes", "tracks", "add-multiple")
			.body(["track-ids": trackIDs])
			.bodyEncoder(.formURL)
			.post()
	}
	
	func like(albumIDs: [String], userID id: Int) async throws {
		try await client("users", "\(id)", "likes", "albums", "add-multiple")
			.body(["album-ids": albumIDs])
			.bodyEncoder(.formURL)
			.post()
	}
	
	func like(artistIDs: [String], userID id: Int) async throws {
		try await client("users", "\(id)", "likes", "artists", "add-multiple")
			.body(["artist-ids": artistIDs])
			.bodyEncoder(.formURL)
			.post()
	}
}
