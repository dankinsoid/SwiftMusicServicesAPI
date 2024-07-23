import Foundation
import SwiftAPIClient

extension Tidal.Objects {

    public struct Page<T> {

        public var limit: Int?
        public var offset: Int
        public var totalNumberOfItems: Int
        public var items: [T]
        public var eTag: String?

        public init(limit: Int? = nil, offset: Int, totalNumberOfItems: Int, items: [T], eTag: String? = nil) {
            self.limit = limit
            self.offset = offset
            self.totalNumberOfItems = totalNumberOfItems
            self.items = items
            self.eTag = eTag
        }
    }
}

extension Tidal.Objects.Page: Equatable where T: Equatable {}
extension Tidal.Objects.Page: Decodable where T: Decodable {}
extension Tidal.Objects.Page: Encodable where T: Encodable {}

public struct TidalPaging<T: Decodable>: AsyncSequence {

    public typealias Element = Tidal.Objects.Page<T>
    let client: APIClient
    let limit: Int?
    let offset: Int

    public init(client: APIClient, limit: Int?, offset: Int) {
        self.client = client
        self.limit = limit
        self.offset = offset
    }

    public func makeAsyncIterator() -> AsyncIterator {
        AsyncIterator(client: client, limit: limit, offset: offset, needFetch: limit)
    }

    public func first() async throws -> Tidal.Objects.Page<T> {
        var iterator = makeAsyncIterator()
        let result = try await iterator.next()
        return result ?? Tidal.Objects.Page(limit: limit, offset: offset, totalNumberOfItems: 0, items: [])
    }

    public struct AsyncIterator: AsyncIteratorProtocol {

        public typealias Element = Tidal.Objects.Page<T>
        let client: APIClient
        var limit: Int?
        var offset: Int
        var needFetch: Int?

        public mutating func next() async throws -> Tidal.Objects.Page<T>? {
            guard (needFetch ?? .max) > 0 else { return nil }
            var (page, response) = try await client
                .query(["limit": limit, "offset": offset])
                .call(.httpResponse, as: .decodable(Tidal.Objects.Page<T>.self))
            page.eTag = response.headerFields[.eTag]
            offset += page.items.count
            limit? -= page.items.count
            if needFetch == nil {
                needFetch = page.totalNumberOfItems - page.items.count
            } else {
                needFetch? -= page.items.count
            }
            return page
        }
    }
}

extension AsyncSequence {

    public func collect<T>() async throws -> [T] where Element == Tidal.Objects.Page<T> {
        try await reduce(into: []) { result, page in
            result.append(contentsOf: page.items)
        }
    }
}
