import Foundation

public extension YouTube {

	struct Scope: Codable, Hashable, LosslessStringConvertible {

		public let value: String
		public var description: String { value }

		public init(_ value: String) {
			self.value = value
		}

		public init(from decoder: any Decoder) throws {
			try self.init(String(from: decoder))
		}

		public func encode(to encoder: any Encoder) throws {
			try value.encode(to: encoder)
		}
	}
}

public extension YouTube.Scope {

	/// Manage your YouTube account
	static let manageYouTubeAccount = YouTube.Scope("https://www.googleapis.com/auth/youtube")
	/// See a list of your current active channel members, their current level, and when they became a member
	static let channelMembershipsCreator = YouTube.Scope("https://www.googleapis.com/auth/youtube.channel-memberships.creator")
	/// See, edit, and permanently delete your YouTube videos, ratings, comments and captions
	static let forceSSL = YouTube.Scope("https://www.googleapis.com/auth/youtube.force-ssl")
	/// View your YouTube account
	static let readOnly = YouTube.Scope("https://www.googleapis.com/auth/youtube.readonly")
	/// Manage your YouTube videos
	static let upload = YouTube.Scope("https://www.googleapis.com/auth/youtube.upload")
	/// View and manage your assets and associated content on YouTube
	static let partner = YouTube.Scope("https://www.googleapis.com/auth/youtubepartner")
	/// View private information of your YouTube channel relevant during the audit process with a YouTube partner
	static let partnerChannelAudit = YouTube.Scope("https://www.googleapis.com/auth/youtubepartner-channel-audit")

	static let userInfoProfile = YouTube.Scope("https://www.googleapis.com/auth/userinfo.profile")
}
