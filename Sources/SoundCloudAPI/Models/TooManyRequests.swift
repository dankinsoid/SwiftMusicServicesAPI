import Foundation
import SwiftAPIClient

public struct TooManyRequests: Codable, Equatable {

	public var code: Int?
	public var link: String?
	public var message: String?
	public var spamWarningUrn: String?

	public enum CodingKeys: String, CodingKey {

		case code
		case link
		case message
		case spamWarningUrn = "spam_warning_urn"
	}

	public init(
		code: Int? = nil,
		link: String? = nil,
		message: String? = nil,
		spamWarningUrn: String? = nil
	) {
		self.code = code
		self.link = link
		self.message = message
		self.spamWarningUrn = spamWarningUrn
	}
}
