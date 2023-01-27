import Foundation
import SwiftHttp

public protocol SpotifyPaging {
	associatedtype NextParameter
	associatedtype Item
	var items: [Item] { get }
	func nextURL(parameters: NextParameter) -> HttpUrl?
}

extension SPPaging: SpotifyPaging {
	public func nextURL(parameters _: Void) -> HttpUrl? {
		next.flatMap { HttpUrl(string: $0) }
	}

	public func nextURL() -> HttpUrl? {
		nextURL(parameters: ())
	}
}

extension Spotify.API {
	public func pagingRequest<Output: SpotifyPaging & Decodable>(
		output: Output.Type,
		executor: @escaping (HttpRequest) async throws -> HttpResponse,
		url: HttpUrl,
		method: HttpMethod,
		body: Data? = nil,
		parameters: Output.NextParameter,
		headers: [HttpHeaderKey: String],
        limit: Int? = nil,
		validators: [HttpResponseValidator] = [HttpStatusCodeValidator()]
	) -> AsyncThrowingStream<[Output.Item], Error> {
		AsyncThrowingStream { cont in
			self.executeNext(
				output: output,
				request: {
					try await self.decodableRequest(
						executor: executor,
						url: url,
						method: method,
						body: body,
						headers: headers,
						validators: validators
					)
				},
                limit: limit,
				observer: cont,
				parameters: parameters
			)
		}
	}

	private func executeNext<Output: SpotifyPaging & Decodable>(
		output: Output.Type,
		request: @escaping () async throws -> Output,
        limit: Int? = nil,
		observer: AsyncThrowingStream<[Output.Item], Error>.Continuation,
		parameters: Output.NextParameter
	) {
		Task {
			do {
				let result = try await request()
				observer.yield(result.items)
                let newLimit = limit.map { $0 - result.items.count }
                if let url = result.nextURL(parameters: parameters), (newLimit ?? .max) > 0 {
					self.executeNext(
						output: output,
						request: { try await self.next(url: url) },
                        limit: newLimit,
						observer: observer,
						parameters: parameters
					)
				} else {
					observer.finish()
				}
			} catch {
				observer.finish(throwing: error)
			}
		}
	}
}
