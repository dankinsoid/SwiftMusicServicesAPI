import Foundation

public extension AppleMusic.API {

	func mySongs(
        include: [AppleMusic.Objects.Include]? = [.catalog],
        limit: Int? = nil,
        offset: Int = 0
    ) -> AsyncThrowingStream<[AppleMusic.Objects.Item], Error> {
		mySongs(input: MySongsInput(include: include, limit: limit, offset: offset))
	}

	func mySongs(input: MySongsInput) -> AsyncThrowingStream<[AppleMusic.Objects.Item], Error> {
		var input = input
		input.limit = input.limit ?? 100
        return pages(limit: input.limit) { [client, input] in
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

	func songs(storefront: String, ids: [String]) -> AsyncThrowingStream<[AppleMusic.Objects.Item], Error> {
        pages { [client] in
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
	func songsByISRC(storefront: String, isrcs: [String]) -> AsyncThrowingStream<[AppleMusic.Objects.Item], Error> {
        if isrcs.count > 25 {
            return AsyncThrowingStream { [self] continuation in
                Task {
                    do {
                        var index = isrcs.startIndex
                        while index < isrcs.endIndex {
                            let endIndex = min(isrcs.endIndex, isrcs.index(index, offsetBy: 25))
                            let chunk: AsyncThrowingStream<[AppleMusic.Objects.Item], Error> = pages { [index, self] in
                                try await _songsByISRC(storefront: storefront, isrcs: Array(isrcs[index..<endIndex]))
                            }
                            for try await songs in chunk {
                                continuation.yield(songs)
                            }
                            index = endIndex
                        }
                        continuation.finish()
                    } catch {
                        continuation.finish(throwing: error)
                    }
                }
            }
        } else {
            return pages { [self] in
                try await _songsByISRC(storefront: storefront, isrcs: isrcs)
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

private extension AppleMusic.API {

    func _songsByISRC(storefront: String, isrcs: [String]) async throws -> AppleMusic.Objects.Response<AppleMusic.Objects.Item> {
        try await client.path("v1", "catalog", storefront, "songs").query(SongsByISRCInput(isrcs: isrcs)).get()
    }
}
