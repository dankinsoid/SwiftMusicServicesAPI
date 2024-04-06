import Foundation

public enum OneOf<First: Codable & Equatable, Second: Codable & Equatable>: Codable, Equatable {
    
    case first(First)
    case second(Second)
    
    public init(from decoder: Decoder) throws {
        do {
            let first = try First(from: decoder)
            self = .first(first)
        } catch {
            let second = try Second(from: decoder)
            self = .second(second)
        }
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .first(value):
            try value.encode(to: encoder)
        case let .second(value):
            try value.encode(to: encoder)
        }
    }
    
    public var first: First? {
        if case let .first(value) = self {
            return value
        }
        return nil
    }
    
    public var second: Second? {
        if case let .second(value) = self {
            return value
        }
        return nil
    }
}
