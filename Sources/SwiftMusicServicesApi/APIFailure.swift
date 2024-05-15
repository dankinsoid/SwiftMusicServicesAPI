import Foundation
import SwiftHttp

public struct APIFailure: LocalizedError, CustomStringConvertible {

	public let error: Error
	public let url: HttpUrl
	public let method: HttpMethod

	public init(_ error: Error, url: HttpUrl, method: HttpMethod) {
		self.error = error
		self.url = url
		self.method = method
	}

	public static func wrap<T>(url: HttpUrl, method: HttpMethod, request: () async throws -> T) async throws -> T {
		do {
			return try await request()
		} catch {
			throw APIFailure(error, url: url, method: method)
		}
	}

	public var errorDescription: String? {
		description
	}

	public var description: String {
		var errorString = "\(method.rawValue.uppercased()) \(url) failed: "
		if let decoding = error as? DecodingError {
			errorString += "\"\(decoding.humanReadable)\""
		} else {
			errorString += "\"\(error.localizedDescription)\""
		}
		return errorString
	}
}

private extension DecodingError {

	var humanReadable: String {
		switch self {
		case let .typeMismatch(any, context):
			return "Expected \(any) at \(context.humanReadable)"
		case let .valueNotFound(any, context):
			return "Value of \(any) not found at \(context.humanReadable)"
		case let .keyNotFound(codingKey, context):
			return "Key \(context.humanReadable) not found"
		case let .dataCorrupted(context):
			return "Data corrupted at \(context.humanReadable)"
		@unknown default:
			return errorDescription ?? "\(self)"
		}
	}
}

private extension DecodingError.Context {

	var humanReadable: String {
		codingPath.map(\.string).joined()
	}
}

private extension CodingKey {

	var string: String {
		if let intValue {
			return "[\(intValue)]"
		}
		return "." + stringValue
	}
}
