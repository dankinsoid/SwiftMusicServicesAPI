import Foundation
import SwiftHttp
import SwiftMusicServicesApi
import SwiftAPIClient

public extension AppleMusic.API {
    
    func pages<T: Decodable>(
        limit: Int? = nil,
        request: @escaping @Sendable (APIClient) async throws -> AppleMusic.Objects.Response<T>
    ) -> AsyncThrowingStream<[T], Error> {
        AsyncThrowingStream { cont in
            self.executeNext(
                output: T.self,
                limit: limit,
                request: request,
                observer: cont
            )
        }
    }
}

extension AppleMusic.API {

	private func executeNext<Output: Decodable>(
		output: Output.Type,
		limit: Int? = nil,
        path: String? = nil,
		request: @escaping @Sendable (APIClient) async throws -> AppleMusic.Objects.Response<Output>,
		observer: AsyncThrowingStream<[Output], Error>.Continuation
	) {
		Task {
			do {
                let result: AppleMusic.Objects.Response<Output>
                if let path {
                    result = try await request(client.path(path))
                } else {
                    result = try await request(client)
                }
				observer.yield(result.data)
				let newLimit = limit.map { $0 - result.data.count }

				if let next = result.next, (newLimit ?? .max) > 0 {
					self.executeNext(
						output: output,
						limit: newLimit,
                        path: next,
						request: request,
						observer: observer
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
