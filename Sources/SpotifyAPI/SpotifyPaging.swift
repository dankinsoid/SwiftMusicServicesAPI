import Foundation
import SwiftAPIClient

public protocol SpotifyPaging {
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

extension Spotify.API {
	
	public struct Paging<Output: SpotifyPaging & Decodable>: AsyncSequence {
		
		public typealias Element = [Output.Item]
		
		public let client: APIClient
		public let parameters: Output.NextParameter
		public let limit: Int?
		public let request: () async throws -> Output
		
		public init(
			client: APIClient,
			parameters: Output.NextParameter,
			limit: Int?,
			request: @escaping () async throws -> Output
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
			var request: (() async throws -> Output)?
			
			public mutating func next() async throws -> [Output.Item]? {
				guard let request, (limit ?? 1) > 0 else { return nil }
				let result = try await request()
				limit = limit.map { $0 - result.items.count }
				self.request = result.nextURL(parameters: parameters).map { [client] url in
					{
						try await client.url(url).get()
					}
				}
				return result.items
			}
		}
	}

	public func pagingRequest<Output: SpotifyPaging & Decodable>(
		of output: Output.Type,
		parameters: Output.NextParameter,
		limit: Int? = nil,
		request: @escaping () async throws -> Output
	) -> Paging<Output> {
		Paging(
			client: client,
			parameters: parameters,
			limit: limit,
			request: request
		)
	}
}
