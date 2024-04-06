import Foundation
import SwiftAPIClient
import SwiftMusicServicesApi

extension SoundCloud.API {
    
    /// SoundCloud pagination operation
    ///
    /// ```swift
    /// let pages = api.pagination {
    ///    try await $0.me.getLikesTracks()
    /// }
    /// for try await page in pages { ... }
    /// ```
    ///
    /// ```swift
    /// let tracks = api.pagination {
    ///    try await $0.me.getLikesTracks()
    /// }
    /// .collect()
    /// ```
    public func pagination<R: Pagination & Decodable>(
        fileID: String = #fileID,
        line: UInt = #line,
        _ operation: @escaping (Self) async throws -> R
    ) -> AnyAsyncSequence<R> {
        AsyncThrowingStream { [self] continuation in
            Task {
                do {
                    var result = try await operation(self)
                    continuation.yield(result)
                    while let next = result.nextHref {
                        try Task.checkCancellation()
                        guard let url = URL(string: next) else {
                            continuation.finish(throwing: InvalidURL(url: next))
                            return
                        }
                        result = try await client.modifyRequest { $0.url = url }.get(fileID: fileID, line: line)
                        continuation.yield(result)
                    }
                    continuation.finish()
                } catch {
                    continuation.finish(throwing: error)
                }
            }
        }
        .eraseToAnyAsyncSequence()
    }
}
 
extension SoundCloud.API {
    
    struct InvalidURL: LocalizedError, CustomStringConvertible {
        var url: String
        var description: String { "Invalid URL: \(url)" }
        var localizedDescription: String { description }
    }
}

extension AnyAsyncSequence where Element: Pagination {
    
    /// Wait for all pages and collect elements.
    public func collect() async throws -> [Element.Collection] {
        try await reduce(into: []) { partialResult, page in
            partialResult += (page.collection ?? [])
        }
    }
}
