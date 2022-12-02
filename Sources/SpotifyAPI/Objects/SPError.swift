import Foundation

public struct SPError: Codable, LocalizedError {
	/// The HTTP status code (also returned in the response header; see [Response Status Codes](/documentation/web-api/#response-status-codes) for more information).
	public var status: Int
	/// A short description of the cause of the error.
	public var message: String

	public init(status: Int, message: String) {
		self.status = status
		self.message = message
	}
}

public extension SPError {
	var errorDescription: String? {
		message
	}
}
