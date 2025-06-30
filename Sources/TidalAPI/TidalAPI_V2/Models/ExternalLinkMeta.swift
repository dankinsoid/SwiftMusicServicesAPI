import Foundation
import SwiftAPIClient

public extension TDO {

	/** metadata about an external link */
	struct ExternalLinkMeta: Codable, Equatable, Sendable {

		public var type: TypeEnum

		public enum CodingKeys: String, CodingKey {

			case type
		}

		public init(
			type: TypeEnum
		) {
			self.type = type
		}

		/** metadata about an external link */
		public enum TypeEnum: String, Codable, Equatable, CaseIterable, CustomStringConvertible, Sendable {
			case tidalSharing = "TIDAL_SHARING"
			case tidalAutoplayAndroid = "TIDAL_AUTOPLAY_ANDROID"
			case tidalAutoplayIos = "TIDAL_AUTOPLAY_IOS"
			case tidalAutoplayWeb = "TIDAL_AUTOPLAY_WEB"
			case twitter = "TWITTER"
			case facebook = "FACEBOOK"
			case instagram = "INSTAGRAM"
			case tiktok = "TIKTOK"
			case snapchat = "SNAPCHAT"
			case homepage = "HOMEPAGE"
			case undecoded

			public init(from decoder: Decoder) throws {
				let container = try decoder.singleValueContainer()
				let rawValue = try container.decode(String.self)
				self = TypeEnum(rawValue: rawValue) ?? .undecoded
			}

			public var description: String { rawValue }
		}
	}
}
