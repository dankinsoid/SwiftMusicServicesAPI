import Foundation
import SwiftHttp
import VDCodable

public extension AppleMusic.API {
	func mySongs(include: [AppleMusic.Objects.Include]? = [.catalog], limit: Int? = nil, offset: Int = 0) throws -> AsyncThrowingStream<[AppleMusic.Objects.Item], Error> {
		try mySongs(input: MySongsInput(include: include, limit: limit, offset: offset))
	}

	func mySongs(input: MySongsInput) throws -> AsyncThrowingStream<[AppleMusic.Objects.Item], Error> {
		var input = input
		input.limit = input.limit ?? 100
		return try dataRequest(
			url: baseURL.path("v1", "me", "library", "songs").query(from: input),
			limit: input.limit
		)
	}

	struct MySongsInput: Encodable {
		public var include: [AppleMusic.Objects.Include]?
		public var limit: Int?
		public var offset: Int
	}
}

public extension AppleMusic.API {

	func songs(storefront: String, ids: [String]) throws -> AsyncThrowingStream<[AppleMusic.Objects.Item], Error> {
		try dataRequest(
			url: baseURL.path("v1", "catalog", storefront, "songs").query(from: SongsInput(ids: ids)),
			limit: nil
		)
	}

	struct SongsInput: Encodable {
		public var ids: [String]
	}
}

public extension AppleMusic.API {
	func songsByISRC(storefront: String, isrcs: [String]) throws -> AsyncThrowingStream<[AppleMusic.Objects.Item], Error> {
		try dataRequest(
			url: baseURL.path("v1", "catalog", storefront, "songs").query(from: SongsByISRCInput(isrcs: isrcs)),
			limit: nil
		)
	}

	struct SongsByISRCInput: Encodable {
		public var isrcs: [String]

		private enum CodingKeys: String, CodingKey, CaseIterable {
			case isrcs = "filter[isrc]"
		}
	}
}
