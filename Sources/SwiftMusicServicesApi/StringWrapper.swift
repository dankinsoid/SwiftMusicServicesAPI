import Foundation

public protocol StringWrapper: Codable, Hashable, CodingKey, LosslessStringConvertible, ExpressibleByStringInterpolation where StringInterpolation == String.StringInterpolation, StringLiteralType == String {

    init(_ value: String)
}

extension Decodable where Self: StringWrapper {

    public init(from decoder: any Decoder) throws {
        try self.init(String(from: decoder))
    }
}

extension Encodable where Self: StringWrapper {

    public func encode(to encoder: any Encoder) throws {
        try description.encode(to: encoder)
    }
}

extension CodingKey where Self: StringWrapper {

    public var stringValue: String { description }
    public var intValue: Int? { Int(description) }

    public init?(stringValue: String) {
        self.init(stringValue)
    }

    public init?(intValue: Int) {
        self.init("\(intValue)")
    }
}

extension ExpressibleByStringLiteral where Self: StringWrapper {

    public init(stringLiteral value: StringLiteralType) {
        self.init(value)
    }
}

extension StringInterpolationProtocol where Self: StringWrapper {

    public init(stringInterpolation: StringInterpolation) {
        self.init(String(stringInterpolation: stringInterpolation))
    }
}
