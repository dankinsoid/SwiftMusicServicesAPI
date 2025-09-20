import Foundation
import SwiftAPIClient
import SwiftMusicServicesApi

public extension AppleMusic.API {

	func pages<T: Decodable>(
		limit: Int? = nil,
		request: @escaping @Sendable (APIClient) async throws -> AppleMusic.Objects.Response<T>
	) -> Pages<T> {
		Pages(client: client, limit: limit, input: true) { client, isFirst in
			if isFirst {
				isFirst = false
				return try await request(client)
			} else {
				return nil
			}
		}
	}
}

public extension AsyncSequence where Element: AppleMusicPageResponse {

	func collect() async throws -> [Element.Item] {
		try await reduce(into: []) { $0 += $1.data }
	}
}

public extension AppleMusic.API {

	typealias Pages<Output: Decodable> = FlatMapPages<Output, Bool>

	struct FlatMapPages<Output: Decodable, Input>: AsyncSequence {

		public typealias Element = [Output]

		let client: APIClient
		let limit: Int?
		let input: Input
		let request: @Sendable (APIClient, inout Input) async throws -> AppleMusic.Objects.Response<Output>?

		public func makeAsyncIterator() -> AsyncIterator {
			AsyncIterator(pages: self, input: input)
		}

		public struct AsyncIterator: AsyncIteratorProtocol {

			let pages: FlatMapPages
			var receivedCount = 0
			var next: String?
			var didEnd = false
			var input: Input

			public mutating func next() async throws -> [Output]? {
				guard !didEnd, pages.limit.map({ receivedCount < $0 }) != false else {
					return nil
				}
				let result: AppleMusic.Objects.Response<Output>?
				if let next {
					result = try await pages.client.path(next).get()
				} else {
					result = try await pages.request(pages.client, &input)
					if result == nil {
						didEnd = true
					}
				}
				receivedCount += result?.data.count ?? 0
				next = result?.next
				return result?.data
			}
		}
	}
}

extension AppleMusic.API.FlatMapPages: Sendable where Input: Sendable {}
extension AppleMusic.API.FlatMapPages.AsyncIterator: Sendable where Input: Sendable {}
