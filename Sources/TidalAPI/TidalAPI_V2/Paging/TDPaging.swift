import Foundation
import SwiftAPIClient

public extension Tidal.API.V2 {

	/// Creates a paging sequence for single-item responses.
	/// - Parameter limit: Maximum items to fetch. May be exceeded by the last page since Tidal API doesn't support limits.
	/// - Parameter request: Request closure returning a DataDocument
	/// - Note: Count is computed as 1 if data exists, 0 if nil
	@_disfavoredOverload
	func paging<Output: Decodable>(
		limit: Int? = nil,
		_ request: @escaping () async throws -> TDO.DataDocument<Output>
	) -> Paging<Output> {
		Paging<Output>(
			client: client,
			limit: limit,
			request: request
		)
	}

	/// Creates a paging sequence for collection responses.
	/// - Parameter limit: Maximum items to fetch. May be exceeded by the last page since Tidal API doesn't support limits.
	/// - Parameter request: Request closure returning a DataDocument with collection data
	/// - Note: Count is computed as the collection's count property
	func paging<Output: Decodable & Collection>(
		limit: Int? = nil,
		_ request: @escaping () async throws -> TDO.DataDocument<Output>
	) -> Paging<Output> {
		Paging<Output>(
			client: client,
			limit: limit,
			request: request
		)
	}

	/// Async sequence for paginated Tidal API responses.
	/// - Warning: The limit may be exceeded by the last page since Tidal API doesn't support client-side limits.
	struct Paging<Output: Decodable>: AsyncSequence {

		public typealias Element = TDO.DataDocument<Output>

		public let client: APIClient
		/// Current remaining item limit. May be exceeded by the last page.
		public var limit: Int
		public let request: () async throws -> TDO.DataDocument<Output>
		/// Computes item count from response data
		private let count: (TDO.DataDocument<Output>) -> Int
		/// Next page URL path from API response links
		public private(set) var nextPath: String?

		/// Initializer for single-item responses
		/// - Note: Count computed as 1 if data exists, 0 if nil
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
			count = { $0.data == nil ? 0 : 1 }
		}

		/// Initializer for collection responses
		/// - Note: Count computed as collection's count property
		public init(
			of type: Output.Type = Output.self,
			client: APIClient,
			limit: Int?,
			pageCursor: String? = nil,
			request: @escaping () async throws -> TDO.DataDocument<Output>
		) where Output: Collection {
			self.client = client
			self.limit = limit ?? .max
			count = { $0.data?.count ?? 0 }
			self.request = request
		}

		public func makeAsyncIterator() -> AsyncIterator {
			AsyncIterator(paging: self)
		}

		/// Async iterator for paging through API responses
		public struct AsyncIterator: AsyncIteratorProtocol {

			var paging: Paging<Output>?

			/// Whether more pages are available based on remaining limit
			public var hasMore: Bool { (paging?.limit ?? 0) > 0 }

			/// Fetches the next page of results
			/// - Warning: May exceed the original limit on the final page
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
					self.paging = paging
				} else {
					self.paging = nil
				}
				return result
			}
		}
	}
}
