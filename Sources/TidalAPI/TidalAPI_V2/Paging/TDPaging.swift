import Foundation
import SwiftAPIClient

extension Tidal.API.V2 {

	@_disfavoredOverload
	public func paging<Output: Decodable>(
		limit: Int? = nil,
		_ request: @escaping () async throws -> TDO.DataDocument<Output>
	) -> Paging<Output> {
		Paging<Output>(
			client: client,
			limit: limit,
			request: request
		)
	}

	public func paging<Output: Decodable & Collection>(
		limit: Int? = nil,
		_ request: @escaping () async throws -> TDO.DataDocument<Output>
	) -> Paging<Output> {
		Paging<Output>(
			client: client,
			limit: limit,
			request: request
		)
	}
	
	public struct Paging<Output: Decodable>: AsyncSequence {

		public typealias Element = TDO.DataDocument<Output>

		public let client: APIClient
		public var limit: Int
		public let request: () async throws -> TDO.DataDocument<Output>
		private let count: (TDO.DataDocument<Output>) -> Int
		private(set) public var nextPath: String?

		@_disfavoredOverload
		public init(
			of type: Output.Type = Output.self,
			client: APIClient,
			limit: Int?,
			request: @escaping () async throws -> TDO.DataDocument<Output>
		) {
			self.client = client
			self.limit = limit ?? .max
			self.request = request
			self.count = { $0.data == nil ? 0 : 1 }
		}

		public init(
			of type: Output.Type = Output.self,
			client: APIClient,
			limit: Int?,
			pageCursor: String? = nil,
			request: @escaping () async throws -> TDO.DataDocument<Output>
		) where Output: Collection {
			self.client = client
			self.limit = limit ?? .max
			self.count = { $0.data?.count ?? 0 }
			self.request = request
		}

		public func makeAsyncIterator() -> AsyncIterator {
			AsyncIterator(paging: self)
		}

		public struct AsyncIterator: AsyncIteratorProtocol {

			var paging: Paging<Output>?

			public var hasMore: Bool { (paging?.limit ?? 0) > 0 }

			public mutating func next() async throws -> TDO.DataDocument<Output>? {
				guard var paging, paging.limit > 0 else { return nil }

				let result: TDO.DataDocument<Output>
				if let nextPath = paging.nextPath {
					result = try await paging.client.path(nextPath).call(.http, as: .decodable)
				} else {
					result = try await paging.request()
				}
	
				let newLimit = paging.limit - paging.count(result)
				paging.limit = newLimit
				if newLimit > 0, let nextPath = result.links?.next {
					paging.nextPath = nextPath
					paging.limit = newLimit
					self.paging = paging
				} else {
					self.paging = nil
				}
				return result
			}
		}
	}
}
