import Foundation
import SwiftAPIClient

/** SoundCloud Me object */
public struct Me: Codable, Equatable {

	/** URL to a JPEG image. */
	public var avatarURL: String?
	/** city. */
	public var city: String?
	/** country. */
	public var country: String?
	/** created at date */
	public var createdAt: String?
	/** description. */
	public var description: String?
	/** discogs name. */
	public var discogsName: String?
	/** first name. */
	public var firstName: String?
	/** number of followers. */
	public var followersCount: Int?
	/** number of followed users. */
	public var followingsCount: Int?
	/** first and last name. */
	public var fullName: String?
	/** unique identifier */
	public var id: Int?
	/** kind of resource. */
	public var kind: String?
	/** last modified timestamp. */
	public var lastModified: String?
	/** last name. */
	public var lastName: String?
	/** likes count. */
	public var likesCount: Int?
	/** locale. */
	public var locale: String?
	/** online. */
	public var online: Bool?
	/** permalink of the resource. */
	public var permalink: String?
	/** URL to the SoundCloud.com page. */
	public var permalinkURL: String?
	/** subscription plan of the user. */
	public var plan: String?
	/** number of public playlists. */
	public var playlistCount: Int?
	/** boolean if email is confirmed. */
	public var primaryEmailConfirmed: Bool?
	/** number of private playlists. */
	public var privatePlaylistsCount: Int?
	/** number of private tracks. */
	public var privateTracksCount: Int?
	/** number of favorited public tracks */
	public var publicFavoritesCount: Int?
	/** user's upload quota */
	public var quota: Quota?
	/** number of reposts from user */
	public var repostsCount: Int?
	/** a list subscriptions associated with the user */
	public var subscriptions: [Subscriptions]?
	/** number of public tracks. */
	public var trackCount: Int?
	/** upload seconds left. */
	public var uploadSecondsLeft: Int?
	/** API resource URL. */
	public var uri: String?
	/** username */
	public var username: String?
	/** a URL to the website. */
	public var website: String?
	/** a custom title for the website. */
	public var websiteTitle: String?

	public enum CodingKeys: String, CodingKey {

		case avatarURL = "avatar_url"
		case city
		case country
		case createdAt = "created_at"
		case description
		case discogsName = "discogs_name"
		case firstName = "first_name"
		case followersCount = "followers_count"
		case followingsCount = "followings_count"
		case fullName = "full_name"
		case id
		case kind
		case lastModified = "last_modified"
		case lastName = "last_name"
		case likesCount = "likes_count"
		case locale
		case online
		case permalink
		case permalinkURL = "permalink_url"
		case plan
		case playlistCount = "playlist_count"
		case primaryEmailConfirmed = "primary_email_confirmed"
		case privatePlaylistsCount = "private_playlists_count"
		case privateTracksCount = "private_tracks_count"
		case publicFavoritesCount = "public_favorites_count"
		case quota
		case repostsCount = "reposts_count"
		case subscriptions
		case trackCount = "track_count"
		case uploadSecondsLeft = "upload_seconds_left"
		case uri
		case username
		case website
		case websiteTitle = "website_title"
	}

	public init(
		avatarURL: String? = nil,
		city: String? = nil,
		country: String? = nil,
		createdAt: String? = nil,
		description: String? = nil,
		discogsName: String? = nil,
		firstName: String? = nil,
		followersCount: Int? = nil,
		followingsCount: Int? = nil,
		fullName: String? = nil,
		id: Int? = nil,
		kind: String? = nil,
		lastModified: String? = nil,
		lastName: String? = nil,
		likesCount: Int? = nil,
		locale: String? = nil,
		online: Bool? = nil,
		permalink: String? = nil,
		permalinkURL: String? = nil,
		plan: String? = nil,
		playlistCount: Int? = nil,
		primaryEmailConfirmed: Bool? = nil,
		privatePlaylistsCount: Int? = nil,
		privateTracksCount: Int? = nil,
		publicFavoritesCount: Int? = nil,
		quota: Quota? = nil,
		repostsCount: Int? = nil,
		subscriptions: [Subscriptions]? = nil,
		trackCount: Int? = nil,
		uploadSecondsLeft: Int? = nil,
		uri: String? = nil,
		username: String? = nil,
		website: String? = nil,
		websiteTitle: String? = nil
	) {
		self.avatarURL = avatarURL
		self.city = city
		self.country = country
		self.createdAt = createdAt
		self.description = description
		self.discogsName = discogsName
		self.firstName = firstName
		self.followersCount = followersCount
		self.followingsCount = followingsCount
		self.fullName = fullName
		self.id = id
		self.kind = kind
		self.lastModified = lastModified
		self.lastName = lastName
		self.likesCount = likesCount
		self.locale = locale
		self.online = online
		self.permalink = permalink
		self.permalinkURL = permalinkURL
		self.plan = plan
		self.playlistCount = playlistCount
		self.primaryEmailConfirmed = primaryEmailConfirmed
		self.privatePlaylistsCount = privatePlaylistsCount
		self.privateTracksCount = privateTracksCount
		self.publicFavoritesCount = publicFavoritesCount
		self.quota = quota
		self.repostsCount = repostsCount
		self.subscriptions = subscriptions
		self.trackCount = trackCount
		self.uploadSecondsLeft = uploadSecondsLeft
		self.uri = uri
		self.username = username
		self.website = website
		self.websiteTitle = websiteTitle
	}

	/** user's upload quota */
	public struct Quota: Codable, Equatable {

		/** unlimited upload quota. */
		public var unlimitedUploadQuota: Bool?
		/** upload seconds left. */
		public var uploadSecondsLeft: Int?
		/** upload seconds used. */
		public var uploadSecondsUsed: Int?

		public enum CodingKeys: String, CodingKey {

			case unlimitedUploadQuota = "unlimited_upload_quota"
			case uploadSecondsLeft = "upload_seconds_left"
			case uploadSecondsUsed = "upload_seconds_used"
		}

		public init(
			unlimitedUploadQuota: Bool? = nil,
			uploadSecondsLeft: Int? = nil,
			uploadSecondsUsed: Int? = nil
		) {
			self.unlimitedUploadQuota = unlimitedUploadQuota
			self.uploadSecondsLeft = uploadSecondsLeft
			self.uploadSecondsUsed = uploadSecondsUsed
		}
	}
}
