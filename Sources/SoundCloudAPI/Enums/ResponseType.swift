
/** Support only the Authorization Code Flow */
public enum ResponseType: String, Codable, Equatable, CaseIterable, CustomStringConvertible {
	case code
	case undecoded

	public init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		let rawValue = try container.decode(String.self)
		self = ResponseType(rawValue: rawValue) ?? .undecoded
	}

	public var description: String { rawValue }
}
