import Foundation
import SwiftAPIClient

public struct YTPaging<Output: Decodable>: AsyncSequence {

    public typealias Element = [Output]

    public let client: APIClient
    public var limit: Int
    public var pageToken: String?
    let setMaxResults: Bool

    public init(
        of type: Output.Type = Output.self,
        client: APIClient,
        limit: Int?,
        setMaxResults: Bool = true,
        pageToken: String? = nil
    ) {
        self.client = client
        self.limit = limit ?? .max
        self.pageToken = pageToken
        self.setMaxResults = setMaxResults
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

        public var hasMore: Bool { (paging?.limit ?? 0) > 0 }
        public var nextPageToken: String? { paging?.pageToken }
        private(set) public var prevPageToken: String?

        public mutating func next() async throws -> [Output]? {
            guard var paging, paging.limit > 0 else { return nil }
    
            let result = try await paging.client
                .query([
                    "pageToken": paging.pageToken,
                    "maxResults": paging.setMaxResults ? Swift.min(50, Swift.max(0, paging.limit)) : nil
                ])
                .call(.http, as: .decodable(YTO.Response<Output>.self))
    
            let newLimit = paging.limit - result.items.count
            paging.limit = newLimit
            if let pageToken = result.nextPageToken, newLimit > 0 {
                paging.pageToken = pageToken
                paging.limit = newLimit
                prevPageToken = result.prevPageToken
                self.paging = paging
            } else {
                prevPageToken = paging.pageToken
                self.paging = nil
            }
            return result.items
        }
    }
}
