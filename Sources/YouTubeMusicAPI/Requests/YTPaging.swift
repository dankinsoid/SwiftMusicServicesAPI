import Foundation
import SwiftAPIClient

public struct YTPaging<Output: Decodable>: AsyncSequence {

    public typealias Element = [Output]

    public let client: APIClient
    public var limit: Int?
    public var pageToken: String?

    public init(
        of type: Output.Type = Output.self,
        client: APIClient,
        limit: Int? = nil,
        pageToken: String? = nil
    ) {
        self.client = client
        self.limit = limit
        self.pageToken = pageToken
    }

    public func first() async throws -> [Output] {
        var iterator = makeAsyncIterator()
        return try await iterator.next() ?? []
    }

    public func makeAsyncIterator() -> AsyncIterator {
        AsyncIterator(paging: self)
    }

    public struct AsyncIterator: AsyncIteratorProtocol {

        var paging: YTPaging<Output>?

        public mutating func next() async throws -> [Output]? {
            guard var paging else { return nil }
    
            let result = try await paging.client
                .query([
                    "pageToken": paging.pageToken,
                    "maxResults": Swift.min(50, Swift.max(0, paging.limit ?? .max))
                ])
                .call(.http, as: .decodable(YTMO.Response<Output>.self))
    
            let newLimit = paging.limit.map { $0 - result.items.count }
            paging.limit = newLimit
            if let pageToken = result.nextPageToken, (newLimit ?? .max) > 0 {
                paging.pageToken = pageToken
                paging.limit = newLimit
                self.paging = paging
            } else {
                self.paging = nil
            }
            return result.items
        }
    }
}
