import Foundation
import SwiftMusicServicesApi
import SwiftAPIClient

public extension AppleMusic.API {
    
    func pages<T: Decodable>(
        limit: Int? = nil,
        request: @escaping @Sendable () async throws -> AppleMusic.Objects.Response<T>
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
		request: @escaping @Sendable () async throws -> AppleMusic.Objects.Response<Output>,
		observer: AsyncThrowingStream<[Output], Error>.Continuation
	) {
		Task { [client] in
			do {
                let result = try await request()
				observer.yield(result.data)
				let newLimit = limit.map { $0 - result.data.count }

				if let next = result.next, (newLimit ?? .max) > 0 {
					self.executeNext(
						output: output,
						limit: newLimit,
                        request: { try await client.path(next).get() },
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

extension AsyncSequence where Element: AppleMusicPageResponse {
    
    public func collect() async throws -> [Element.Item] {
        try await reduce(into: []) { $0 += $1.data }
    }
}
