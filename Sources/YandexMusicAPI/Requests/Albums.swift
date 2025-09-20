import Foundation
import SimpleCoders
import SwiftAPIClient
import SwiftMusicServicesApi

public extension Yandex.Music.API {

	func albums(ids: [String]) -> AlbumsSequence {
		AlbumsSequence(ids: ids, withPositions: true, client: client)
	}

	struct AlbumsSequence: AsyncSequence {

		public typealias Element = [YMO.Album]

		let ids: [String]
		let withPositions: Bool
		let client: APIClient

		public func makeAsyncIterator() -> AsyncIterator {
			AsyncIterator(ids: ids, withPositions: withPositions, client: client)
		}

		public struct AsyncIterator: AsyncIteratorProtocol {

			public typealias Element = [YMO.Album]

			let ids: [String]
			let withPositions: Bool
			let client: APIClient
			let maxSize = 100
			var offset = 0

			public mutating func next() async throws -> [YMO.Album]? {
				guard offset < ids.count else { return nil }
				let chunk = Array(ids[offset ..< Swift.min(offset + maxSize, ids.count)])
				offset += maxSize
				return try await client("albums")
					.query(AlbumsInput(ids: chunk))
					.method(.post)
					.call(.http, as: .decodable([YMO.Album].self))
			}
		}
	}

	struct AlbumsInput: Encodable {

		public var ids: [String]
		public var withPositions: Bool

		enum CodingKeys: String, CodingKey, CaseIterable {

			case ids = "album-ids", withPositions = "with-positions"
		}

		public init(ids: [String], withPositions: Bool = true) {
			self.ids = ids
			self.withPositions = withPositions
		}
	}
}
