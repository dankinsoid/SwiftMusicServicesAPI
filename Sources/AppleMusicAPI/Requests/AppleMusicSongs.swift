import Foundation
import SwiftAPIClient

public extension AppleMusic.API {

	func mySongs(
        include: [AppleMusic.Objects.Include]? = [.catalog],
        limit: Int? = nil,
        offset: Int = 0
    ) -> Pages<AppleMusic.Objects.Item> {
		mySongs(input: MySongsInput(include: include, limit: limit, offset: offset))
	}

	func mySongs(input: MySongsInput) -> Pages<AppleMusic.Objects.Item> {
		var input = input
		input.limit = input.limit ?? 100
        return pages(limit: input.limit) { [input] client in
            try await client.path("v1", "me", "library", "songs").query(input).get()
        }
	}

	func equivalent(
		of id: String,
		for storefront: String,
		language: String? = nil
	) async throws -> AppleMusic.Objects.Item {
		try await client.path("v1", "catalog", storefront, "songs")
			.query(["filter[equivalents]": id, "l": language])
			.call(.http, as: .decodable(AppleMusic.Objects.Response<AppleMusic.Objects.Item>.self))
			.data
			.first
			.unwrap(throwing: "No equivalent song found for \(id) in \(storefront)")
	}

    func add(ids: [String], type: AppleMusic.TrackType, language: String? = nil) async throws {
        var ids = ids
        let limit = 150
        while !ids.isEmpty {
            try await client.path("v1", "me", "library", "songs")
                .query(["ids[\(type.rawValue)]": Array(ids.prefix(limit)), "l": language])
                .post()
            ids.removeFirst(min(limit, ids.count))
        }
    }

	struct MySongsInput: Encodable {
		public var include: [AppleMusic.Objects.Include]?
		public var limit: Int?
		public var offset: Int
	}
}

public extension AppleMusic.API {

	func songs(storefront: String, ids: [String]) -> Pages<AppleMusic.Objects.Item> {
        pages { client in
            try await client.path("v1", "catalog", storefront, "songs").query(SongsInput(ids: ids)).get()
        }
	}

	struct SongsInput: Encodable {
		public var ids: [String]
	}
}

public extension AppleMusic.API {

    /// [Documentation](https://developer.apple.com/documentation/applemusicapi/get_multiple_catalog_songs_by_isrc)
    ///
    /// Fetch one or more songs by using their International Standard Recording Code (ISRC) values.
    /// - Parameters:
    ///   - storefront: An iTunes Store territory, specified by an ISO 3166 alpha-2 country code. The possible values are the id attributes of Storefront objects.
    ///   - isrcs: The International Standard Recording Code (ISRC) values for the songs. You can substitute filter[isrc] for ids, or use it in conjunction with ids for additional filtering. Note that one ISRC value may return more than one song.
    ///   - limit: The limit on the number of objects, or number of objects in the specified relationship, that are returned.
    func songsByISRC(storefront: String, isrcs: [String], limit: Int? = nil) -> FlatMapPages<AppleMusic.Objects.Item, [String]> {
        FlatMapPages(client: client, limit: limit, input: isrcs) { client, isrcs in
            if !isrcs.isEmpty {
                let limitPerPage = 25
                let isrcsPrefix = Array(isrcs.prefix(limitPerPage))
                isrcs = Array(isrcs.dropFirst(limitPerPage))
                return try await client
                    .path("v1", "catalog", storefront, "songs")
                    .query(SongsByISRCInput(isrcs: isrcsPrefix))
                    .get()
            } else {
                return nil
            }
        }
	}

	struct SongsByISRCInput: Encodable {

		public var isrcs: [String]

		private enum CodingKeys: String, CodingKey, CaseIterable {

			case isrcs = "filter[isrc]"
		}
	}
}

private func _songsByISRC(client: APIClient, storefront: String, isrcs: [String]) async throws -> AppleMusic.Objects.Response<AppleMusic.Objects.Item> {
    try await client.path("v1", "catalog", storefront, "songs").query(AppleMusic.API.SongsByISRCInput(isrcs: isrcs)).get()
}
