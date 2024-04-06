import Foundation
import SwiftAPIClient

/** User's Comment */
public struct Comment: Codable, Equatable {

	/** Comment body. */
	public var body: String?
	/** Created timestamp. */
	public var createdAt: String?
	/** Identifier. */
	public var id: Int?
	/** Kind (comment). */
	public var kind: String?
	/** Timestamp. */
	public var timestamp: String?
	/** Track's identifier. */
	public var trackId: Int?
	/** Comment's URL. */
	public var uri: String?
	/** SoundCloud User object */
	public var user: User?
	/** User's identifier. */
	public var userId: Int?

	public enum CodingKeys: String, CodingKey {

		case body
		case createdAt = "created_at"
		case id
		case kind
		case timestamp
		case trackId = "track_id"
		case uri
		case user
		case userId = "user_id"
	}

	public init(
		body: String? = nil,
		createdAt: String? = nil,
		id: Int? = nil,
		kind: String? = nil,
		timestamp: String? = nil,
		trackId: Int? = nil,
		uri: String? = nil,
		user: User? = nil,
		userId: Int? = nil
	) {
		self.body = body
		self.createdAt = createdAt
		self.id = id
		self.kind = kind
		self.timestamp = timestamp
		self.trackId = trackId
		self.uri = uri
		self.user = user
		self.userId = userId
	}

	/** SoundCloud User object */
	public struct User: Codable, Equatable {

		/** URL to a JPEG image. */
		public var avatarURL: String?
		/** number of followers. */
		public var followersCount: Int?
		/** number of followed users. */
		public var followingsCount: Int?
		/** unique identifier */
		public var id: Int?
		/** kind of resource. */
		public var kind: String?
		/** last modified timestamp. */
		public var lastModified: String?
		/** permalink of the resource. */
		public var permalink: String?
		/** URL to the SoundCloud.com page. */
		public var permalinkURL: String?
		/** number of reposts from user */
		public var repostsCount: Int?
		/** API resource URL. */
		public var uri: String?
		/** username */
		public var username: String?

		public enum CodingKeys: String, CodingKey {

			case avatarURL = "avatar_url"
			case followersCount = "followers_count"
			case followingsCount = "followings_count"
			case id
			case kind
			case lastModified = "last_modified"
			case permalink
			case permalinkURL = "permalink_url"
			case repostsCount = "reposts_count"
			case uri
			case username
		}

		public init(
			avatarURL: String? = nil,
			followersCount: Int? = nil,
			followingsCount: Int? = nil,
			id: Int? = nil,
			kind: String? = nil,
			lastModified: String? = nil,
			permalink: String? = nil,
			permalinkURL: String? = nil,
			repostsCount: Int? = nil,
			uri: String? = nil,
			username: String? = nil
		) {
			self.avatarURL = avatarURL
			self.followersCount = followersCount
			self.followingsCount = followingsCount
			self.id = id
			self.kind = kind
			self.lastModified = lastModified
			self.permalink = permalink
			self.permalinkURL = permalinkURL
			self.repostsCount = repostsCount
			self.uri = uri
			self.username = username
		}
	}
}
