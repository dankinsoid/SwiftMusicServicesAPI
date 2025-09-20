import Foundation
import SwiftAPIClient

public protocol SpotifyPaging: Sendable {
	associatedtype NextParameter
	associatedtype Item
	var items: [Item] { get }
	func nextURL(parameters: NextParameter) -> URL?
}

extension SPPaging: SpotifyPaging {

	public func nextURL(parameters _: Void) -> URL? {
		next.flatMap { URL(string: $0) }
	}

	public func nextURL() -> URL? {
		nextURL(parameters: ())
	}
}

public extension Spotify.API {

	struct Paging<Output: SpotifyPaging & Codable>: AsyncSequence {

		public typealias Element = [Output.Item]

		public let client: APIClient
		public let parameters: Output.NextParameter
		public let limit: Int?
		public let request: @Sendable () async throws -> Output

		public init(
			client: APIClient,
			parameters: Output.NextParameter,
			limit: Int?,
			request: @escaping @Sendable () async throws -> Output
		) {
			self.client = client
			self.parameters = parameters
			self.limit = limit
			self.request = request
		}

		public func makeAsyncIterator() -> AsyncIterator {
			AsyncIterator(
				client: client,
				parameters: parameters,
				limit: limit,
				request: request
			)
		}

		public struct AsyncIterator: AsyncIteratorProtocol {

			let client: APIClient
			let parameters: Output.NextParameter
			var limit: Int?
			var request: (@Sendable () async throws -> Output)?

			public mutating func next() async throws -> [Output.Item]? {
				guard let request, (limit ?? 1) > 0 else { return nil }
				let result = try await request()
				limit = limit.map { $0 - result.items.count }
				if let nextURL = result.nextURL(parameters: parameters) {
					self.request = { [client] in
						try await client.url(nextURL).get()
					}
				} else {
					self.request = nil
				}
				return result.items
			}
		}
	}

	func pagingRequest<Output: SpotifyPaging & Codable>(
		of output: Output.Type,
		parameters: Output.NextParameter,
		limit: Int? = nil,
		request: @escaping @Sendable () async throws -> Output
	) -> Paging<Output> {
		Paging(
			client: client,
			parameters: parameters,
			limit: limit,
			request: request
		)
	}
}

extension Spotify.API.Paging: Sendable where Output: Sendable, Output.Item: Sendable, Output.NextParameter: Sendable {}
extension Spotify.API.Paging.AsyncIterator: Sendable where Output: Sendable, Output.Item: Sendable, Output.NextParameter: Sendable {}
