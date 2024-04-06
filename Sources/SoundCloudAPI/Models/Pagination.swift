import Foundation

public protocol Pagination {
    
    associatedtype Collection
    var collection: [Collection]? { get }
    var nextHref: String? { get }
}

extension OneOf where First: Pagination, Second == [First.Collection] {

    public var collection: [First.Collection]? {
        switch self {
        case .first(let first):
            return first.collection
        case .second(let second):
            return second
        }
    }

    public var nextHref: String? {
        first?.nextHref
    }
}
