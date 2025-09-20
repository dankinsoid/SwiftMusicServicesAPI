import Foundation

public struct AnyError: LocalizedError, LosslessStringConvertible {

	public var description: String
	public var errorDescription: String? { description }

	public init(_ description: String) {
		self.description = description
	}
}
