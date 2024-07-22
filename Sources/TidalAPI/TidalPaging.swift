import Foundation
import SwiftAPIClient

extension Tidal.Objects {

    public struct Page<T> {

        public var limit: Int?
        public var offset: Int
        public var totalNumberOfItems: Int
        public var items: [T]

        public init(limit: Int? = nil, offset: Int, totalNumberOfItems: Int, items: [T]) {
            self.limit = limit
            self.offset = offset
            self.totalNumberOfItems = totalNumberOfItems
            self.items = items
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
        AsyncIterator(client: client, limit: limit, offset: offset)
    }

    public func first() async throws -> Tidal.Objects.Page<T> {
        var iterator = AsyncIterator(client: client, limit: limit, offset: offset)
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
            let response = try await client
                .query(["limit": limit, "offset": offset])
                .call(.http, as: .decodable(Tidal.Objects.Page<T>.self))
            offset += response.items.count
            limit? -= response.items.count
            if needFetch == nil {
                needFetch = response.totalNumberOfItems - response.items.count
            } else {
                needFetch? -= response.items.count
            }
            return response
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
