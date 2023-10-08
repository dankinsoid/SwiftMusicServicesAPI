import Foundation
import SimpleCoders
import SwiftHttp
import VDCodable

struct YandexDecoder: HttpDataDecoder {
	let decoder: VDJSONDecoder

	init() {
		let decoder = VDJSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase(separators: ["_", "-"])
		decoder.dateDecodingStrategy = ISO8601CodingStrategy()
		self.decoder = decoder
	}

	///
	/// Decodes the response data into a custom decodable object
	///
	/// - Parameter type: The type of the decodable object
	/// - Parameter data: The HttpResponse data
	///
	/// - Throws: `Error` if something was wrong with the decoding
	///
	/// - Returns: The decoded object
	///
	func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
		do {
			return try decoder.decode(type, from: data)
		} catch {
			throw mapError(from: data) ?? error
		}
	}

	private func mapError(from data: Data) -> Error? {
		if let err = try? VDJSONDecoder().decode(YandexError.self, from: data) {
			return err
		} else if let err = try? VDJSONDecoder().decode(YandexFailure.self, from: data) {
			return err
		} else {
			return nil
		}
	}
}
