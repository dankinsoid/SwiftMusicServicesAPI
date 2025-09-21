import Foundation

package extension Optional {

	func unwrap(throwing error: Error) throws -> Wrapped {
		guard let value = self else {
			throw error
		}
		return value
	}

	func unwrap(throwing error: String) throws -> Wrapped {
		try unwrap(throwing: MissingValue(description: error))
	}
}

private struct MissingValue: Error, CustomStringConvertible, LocalizedError {

	var description: String
	var errorDescription: String? { description }
}
