import Foundation
import SwiftAPIClient

public extension TDO {

	struct UserReportCreateOperationPayloadDataAttributes: Codable, Equatable, Sendable {

		public var description: String
		public var reason: Reason

		public enum CodingKeys: String, CodingKey {

			case description
			case reason
		}

		public init(
			description: String,
			reason: Reason
		) {
			self.description = description
			self.reason = reason
		}

		public enum Reason: String, Codable, Equatable, CaseIterable, CustomStringConvertible, Sendable {
			case sexualContentOrNudity = "SEXUAL_CONTENT_OR_NUDITY"
			case violentOrDangerousContent = "VIOLENT_OR_DANGEROUS_CONTENT"
			case hatefulOrAbusiveContent = "HATEFUL_OR_ABUSIVE_CONTENT"
			case harassment = "HARASSMENT"
			case privacyViolation = "PRIVACY_VIOLATION"
			case scamsOrFraud = "SCAMS_OR_FRAUD"
			case spam = "SPAM"
			case copyrightInfringement = "COPYRIGHT_INFRINGEMENT"
			case unknown = "UNKNOWN"
			case undecoded

			public init(from decoder: Decoder) throws {
				let container = try decoder.singleValueContainer()
				let rawValue = try container.decode(String.self)
				self = Reason(rawValue: rawValue) ?? .undecoded
			}

			public var description: String { rawValue }
		}
	}
}
