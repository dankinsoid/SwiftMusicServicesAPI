import Foundation

/// ISO 3166-1 alpha-2
public struct CountryCode: Codable, Hashable, Sendable, RawRepresentable, LosslessStringConvertible, CaseIterable {

	public let rawValue: UInt16
	public var code: String {
		let first = UInt8((rawValue >> 8) & 0xFF)
		let second = UInt8(rawValue & 0xFF)
		return String(UnicodeScalar(first)) + String(UnicodeScalar(second))
	}

	public var description: String { code }

	public init?(_ description: String) {
		guard description.count == 2 else { return nil }
		let uppercased = description.uppercased()
		guard let first = uppercased.first?.asciiValue, let second = uppercased.last?.asciiValue else { return nil }
		self.rawValue = (UInt16(first) << 8) | UInt16(second)
	}

	public init?(rawValue: UInt16) {
		let first = UInt8((rawValue >> 8) & 0xFF)
		let second = UInt8(rawValue & 0xFF)
		guard (65...90).contains(first), (65...90).contains(second) else { return nil }
		self.rawValue = rawValue
	}

	public init(from decoder: any Decoder) throws {
		let raw: UInt16
		// decoding supports both UInt16 and String formats
		do {
			let container = try decoder.singleValueContainer()
			raw = try container.decode(UInt16.self)
		} catch {
			let container = try decoder.singleValueContainer()
			let string = try container.decode(String.self)
			guard let code = CountryCode.parse(string) else {
				throw DecodingError.dataCorruptedError(
					in: container,
					debugDescription: "Invalid country code string: \(string)"
				)
			}
			self = code
			return
		}
		guard let code = CountryCode(rawValue: raw) else {
			let container = try decoder.singleValueContainer()
			throw DecodingError.dataCorruptedError(
				in: container,
				debugDescription: "Invalid country code raw value: \(raw)"
			)
		}
		self = code
	}

	/// Parses a country code from a string, trying to handle common variations and full country names.
	public static func parse(_ description: String) -> CountryCode? {
		if let code = CountryCode(description) {
			return code
		}
		if let raw = UInt16(description), let code = CountryCode(rawValue: raw) {
			return code
		}
		if description.count == 5, !description[description.index(description.startIndex, offsetBy: 2)].isLetter {
			let suffix = description.suffix(2)
			return CountryCode(String(suffix))
		}
		let trimmed = description.filter { $0.isASCII && $0.isLetter }.lowercased()
		if trimmed == "rus" || trimmed.contains("russia") {
			return .RU
		}
		if trimmed.contains("unitedstates") || trimmed.contains("america") || trimmed == "usa" {
			return .US
		}
		if trimmed.contains("unitedkingdom") || trimmed.contains("greatbritain") || trimmed.contains("england") {
			return .UK
		}
		if trimmed.contains("china") {
			return .CN
		}
		if trimmed == "uae" || trimmed.contains("emirates") {
			return .AE
		}
		// add more known mappings if needed
		return nil
	}

	public func encode(to encoder: any Encoder) throws {
		try code.encode(to: encoder)
	}

	public static let AA = CountryCode("AA")!
	public static let AD = CountryCode("AD")!
	public static let AE = CountryCode("AE")!
	public static let AF = CountryCode("AF")!
	public static let AG = CountryCode("AG")!
	public static let AI = CountryCode("AI")!
	public static let US = CountryCode("US")!
	public static let RU = CountryCode("RU")!
	public static let CN = CountryCode("CN")!
	public static let UK = CountryCode("UK")!
	public static let GB = CountryCode("GB")!
	public static let FR = CountryCode("FR")!
	public static let DE = CountryCode("DE")!
	public static let EU = CountryCode("EU")!
	public static let CA = CountryCode("CA")!
	public static let KP = CountryCode("KP")!
	public static let AU = CountryCode("AU")!
	public static let IR = CountryCode("IR")!
	public static let JP = CountryCode("JP")!
	public static let IT = CountryCode("IT")!
	public static let ES = CountryCode("ES")!
	
	public static var allCases: [CountryCode] {
		(0..<26).flatMap { first in
			(0..<26).compactMap { second in
				CountryCode(rawValue: (UInt16(65 + first) << 8) | UInt16(65 + second))
			}
		}
	}
}
