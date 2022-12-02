import Foundation

public struct YandexError: Codable, Error {
	public var error_description: String?
	public var error: String
}

public struct YandexFailure: Codable, Error, Equatable {
	public static let sessionExpired = YandexFailure(
		invocationInfo: nil,
		error: YandexErrorDescription(name: "session-expired", message: "Your OAuth token is likely expired")
	)

	public var invocationInfo: YMO.InvocationInfo?
	public var error: YandexErrorDescription

	public static func == (lhs: YandexFailure, rhs: YandexFailure) -> Bool {
		lhs.error.name == rhs.error.name
	}
}

public struct YandexErrorDescription: Codable, Error {
	public var name: String
	public var message: String // "Your OAuth token is likely expired"
}
