import Foundation
import SwiftAPIClient

public struct SCPaging<T: Codable>: AsyncSequence {

	public typealias Element = SoundCloud.Objects.Page<T>
	let client: APIClient
	let limit: Int?
	let query: (String, [Int])?

	public init(client: APIClient, query: (String, [Int])? = nil, limit: Int?) {
		self.client = client
		self.limit = limit
		self.query = query
	}

	public func makeAsyncIterator() -> AsyncIterator {
		AsyncIterator(
			firstClient: client,
			client: client,
			limit: limit ?? .max,
			query: query
		)
	}

	public func first() async throws -> SoundCloud.Objects.Page<T> {
		var iterator = makeAsyncIterator()
		let result = try await iterator.next()
		return result ?? SoundCloud.Objects.Page(collection: [])
	}

	public struct AsyncIterator: AsyncIteratorProtocol {

		public typealias Element = SoundCloud.Objects.Page<T>

		let firstClient: APIClient
		var client: APIClient?
		var limit: Int
		var next: URL?
		var didFetch = 0
		var query: (String, [Int])?

		public mutating func next() async throws -> SoundCloud.Objects.Page<T>? {
			if didFetch == 0 {
				addQuery()
			}
			guard let client, didFetch < limit else { return nil }
			let page = try await client.call(.http, as: .decodable(SoundCloud.Objects.Page<T>.self))
			didFetch += page.collection.count

			if let next = page.next {
				self.client = firstClient.url(next)
			} else if let query, !query.1.isEmpty {
				addQuery()
			} else {
				self.client = nil
			}

			return page
		}

		private mutating func addQuery() {
			if var query {
				if query.1.isEmpty {
					client = nil
				} else {
					let limit = 50
					let prefix = Array(query.1.prefix(limit))
					query.1.removeFirst(Swift.min(limit, query.1.count))
					self.query = query
					client = firstClient.query(query.0, prefix)
				}
			}
		}
	}
}

public extension AsyncSequence {

	func collect<T>() async throws -> [T] where Element == SoundCloud.Objects.Page<T> {
		try await reduce(into: []) { result, page in
			result.append(contentsOf: page.collection)
		}
	}
}

public extension SoundCloud.Objects {

	struct Page<T> {

		public var collection: [T]
		public var next: URL?

		enum CodingKeys: String, CodingKey {

			case collection
			case next = "next_href"
		}

		public init(collection: [T], next: URL? = nil) {
			self.collection = collection
			self.next = next
		}
	}
}

extension SoundCloud.Objects.Page: Decodable where T: Decodable {

	public init(from decoder: Decoder) throws {
		let container: KeyedDecodingContainer<CodingKeys>
		do {
			container = try decoder.container(keyedBy: CodingKeys.self)
		} catch {
			collection = try [T](from: decoder)
			next = nil
			return
		}
		collection = try container.decode([T].self, forKey: .collection)
		next = try container.decodeIfPresent(URL.self, forKey: .next)
	}
}

extension SoundCloud.Objects.Page: Encodable where T: Encodable {}
extension SoundCloud.Objects.Page: Equatable where T: Equatable {}

extension SoundCloud.Objects.Page: Mockable where T: Mockable {
	public static var mock: SoundCloud.Objects.Page<T> {
		SoundCloud.Objects.Page(
			collection: [T.mock],
			next: nil
		)
	}
}
