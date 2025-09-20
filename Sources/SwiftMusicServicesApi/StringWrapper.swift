import Foundation

public protocol StringWrapper: Codable, Hashable, CodingKey, LosslessStringConvertible, ExpressibleByStringInterpolation where StringInterpolation == String.StringInterpolation, StringLiteralType == String {

	init(_ value: String)
}

public extension Decodable where Self: StringWrapper {

	init(from decoder: any Decoder) throws {
		try self.init(String(from: decoder))
	}
}

public extension Encodable where Self: StringWrapper {

	func encode(to encoder: any Encoder) throws {
		try description.encode(to: encoder)
	}
}

public extension CodingKey where Self: StringWrapper {

	var stringValue: String { description }
	var intValue: Int? { Int(description) }

	init?(stringValue: String) {
		self.init(stringValue)
	}

	init?(intValue: Int) {
		self.init("\(intValue)")
	}
}

public extension ExpressibleByStringLiteral where Self: StringWrapper {

	init(stringLiteral value: StringLiteralType) {
		self.init(value)
	}
}

public extension StringInterpolationProtocol where Self: StringWrapper {

	init(stringInterpolation: StringInterpolation) {
		self.init(String(stringInterpolation: stringInterpolation))
	}
}
