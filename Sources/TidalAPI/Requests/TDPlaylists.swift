import Foundation
import SwiftAPIClient
import SwiftMusicServicesApi

public extension Tidal.API.V1 {

	var playlists: Playlists {
		Playlists(client: client("playlists"))
	}

	struct Playlists {

		public let client: APIClient

		public func callAsFunction(_ id: String) -> Tidal.API.V1.Playlist {
			Tidal.API.V1.Playlist(client: client(id))
		}
	}

	struct Playlist {

		public let client: APIClient
	}
}

public extension Tidal.API.V1.Playlist {

	func items(
		auth: Bool = true,
		limit: Int? = nil,
		offset: Int = 0
	) -> TidalPaging<Tidal.Objects.UserItem<TDO.Track>> {
		TidalPaging(
			client: client("items").auth(enabled: auth),
			limit: limit,
			offset: offset
		)
	}

	func get() async throws -> Tidal.Objects.WithETag<Tidal.Objects.Playlist> {
		let (playlist, response) = try await client
			.call(
				.httpResponse,
				as: .decodable(Tidal.Objects.Playlist.self)
			)
		return Tidal.Objects.WithETag(eTag: response.headerFields[.eTag], value: playlist)
	}

	func add(
		trackIDs: [Int],
		eTag: String? = nil,
		duplicationPolicy: Tidal.Objects.DuplicationPolicy = .skip,
		artifactNotFoundPolicy: Tidal.Objects.NotFoundPolicy = .skip
	) async throws {
		let tag = try await get().eTag
		return try await client("items")
			.body([
				"itemIds": trackIDs,
				"onArtifactNotFound": artifactNotFoundPolicy,
				"onDupes": duplicationPolicy,
			])
			.header("If-None-Match", tag ?? "*")
			.post()
	}
}

public extension Tidal.Objects {

	enum DuplicationPolicy: String, Codable, Equatable, CaseIterable {

		case fail = "FAIL"
		case skip = "SKIP"
		case replace = "REPLACE"
	}

	enum NotFoundPolicy: String, Codable, Equatable, CaseIterable {

		case fail = "FAIL"
		case skip = "SKIP"
	}
}

private struct ETagMustBeSpecified: Error {}
