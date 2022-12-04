import Foundation
import SwiftHttp

struct DecodableFailureDecoder: HttpDataDecoder {
	var decoder: HttpDataDecoder
	var decodeFailure: (Data) throws -> Error

	init(
		decoder: HttpDataDecoder,
		decodeFailure: @escaping (Data) throws -> Error
	) {
		self.decoder = decoder
		self.decodeFailure = decodeFailure
	}

	init(
		_ type: (some Error & Decodable).Type,
		decoder: HttpDataDecoder
	) {
		self.init(decoder: decoder) {
			try decoder.decode(type, from: $0)
		}
	}

	func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
		do {
			return try decoder.decode(type, from: data)
		} catch {
			if let failure = try? decodeFailure(data) {
				throw failure
			}
			switch error {
			case let error as DecodingError:
				throw DecodingReadableError(error: error, data: data)
			default:
				throw error
			}
		}
	}
}

private struct DecodingReadableError: LocalizedError {

	let error: DecodingError
	let data: Data

	var errorDescription: String? {
		switch error {
		case .dataCorrupted(let context):
			return "Data corrupted at \(path(for: context))\(body)"
		case .keyNotFound(let key, let context):
			return "Key \(key.stringValue) not found at \(path(for: context))\(body)"
		case .typeMismatch(let type, let context):
			return "Type \(type) mismatch at \(path(for: context))\(body)"
		case .valueNotFound(let type, let context):
			return "Value of \(type) not found at \(path(for: context))\(body)"
		@unknown default:
			return error.localizedDescription
		}
	}

	private func path(for context: DecodingError.Context) -> String {
		context.codingPath.map(\.stringValue).joined(separator: ".")
	}

	private var body: String {
		guard
			let object = try? JSONSerialization.jsonObject(with: data, options: []),
			let data = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted),
			let prettyPrintedString = String(data: data, encoding: .utf8)
		else {
			return String(data: data, encoding: .utf8) ?? ""
		}
		return "\n" + prettyPrintedString
	}
}

public extension HttpDataDecoder {
	func decodeError(_ type: (some Decodable & Error).Type) -> HttpDataDecoder {
		DecodableFailureDecoder(type, decoder: self)
	}
}
