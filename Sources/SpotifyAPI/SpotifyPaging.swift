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

	public func pagingRequest<Output: SpotifyPaging & Decodable>(
		of output: Output.Type,
		parameters: Output.NextParameter,
		limit: Int? = nil,
        request: @escaping @Sendable () async throws -> Output
	) -> AsyncThrowingStream<[Output.Item], Error> {
		AsyncThrowingStream { cont in
			self.executeNext(
                Output.self,
				limit: limit,
				observer: cont,
				parameters: parameters,
                request: request
            )
		}
	}

	private func executeNext<Output: SpotifyPaging & Decodable>(
        _ type: Output.Type,
		limit: Int? = nil,
		observer: AsyncThrowingStream<[Output.Item], Error>.Continuation,
		parameters: Output.NextParameter,
        request: @escaping @Sendable () async throws -> Output
	) {
		Task { [client] in
			do {
				let result = try await request()
				observer.yield(result.items)
				let newLimit = limit.map { $0 - result.items.count }
				if let url = result.nextURL(parameters: parameters), (newLimit ?? .max) > 0 {
					self.executeNext(
                        type,
						limit: newLimit,
						observer: observer,
						parameters: parameters
                    ){
                        try await client.url(url).get()
                    }
				} else {
					observer.finish()
				}
			} catch {
				observer.finish(throwing: error)
			}
		}
	}
}
