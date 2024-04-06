import Foundation
import SwiftAPIClient

/** SoundCloud User object */
public struct User: Codable, Equatable {

	/** URL to a JPEG image */
	public var avatarURL: String?
	/** city */
	public var city: String?
	/** country */
	public var country: String?
	/** profile creation datetime */
	public var createdAt: Date?
	/** description */
	public var description: String?
	/** discogs name */
	public var discogsName: String?
	/** first name */
	public var firstName: String?
	/** number of followers */
	public var followersCount: Int?
	/** number of followed users */
	public var followingsCount: Int?
	/** first and last name */
	public var fullName: String?
	/** unique identifier */
	public var id: Int?
	/** kind of resource */
	public var kind: String?
	/** last modified datetime */
	public var lastModified: Date?
	/** last name */
	public var lastName: String?
	/** permalink of the resource */
	public var permalink: String?
	/** URL to the SoundCloud.com page */
	public var permalinkURL: String?
	/** subscription plan of the user */
	public var plan: String?
	/** number of public playlists */
	public var playlistCount: Int?
	/** number of favorited public tracks */
	public var publicFavoritesCount: Int?
	/** number of reposts from user */
	public var repostsCount: Int?
	/** number of public tracks */
	public var trackCount: Int?
	/** API resource URL */
	public var uri: String?
	/** username */
	public var username: String?
	/** a URL to the website */
	public var website: String?
	/** a custom title for the website */
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
		case permalink
		case permalinkURL = "permalink_url"
		case plan
		case playlistCount = "playlist_count"
		case publicFavoritesCount = "public_favorites_count"
		case repostsCount = "reposts_count"
		case trackCount = "track_count"
		case uri
		case username
		case website
		case websiteTitle = "website_title"
	}

	public init(
		avatarURL: String? = nil,
		city: String? = nil,
		country: String? = nil,
		createdAt: Date? = nil,
		description: String? = nil,
		discogsName: String? = nil,
		firstName: String? = nil,
		followersCount: Int? = nil,
		followingsCount: Int? = nil,
		fullName: String? = nil,
		id: Int? = nil,
		kind: String? = nil,
		lastModified: Date? = nil,
		lastName: String? = nil,
		permalink: String? = nil,
		permalinkURL: String? = nil,
		plan: String? = nil,
		playlistCount: Int? = nil,
		publicFavoritesCount: Int? = nil,
		repostsCount: Int? = nil,
		trackCount: Int? = nil,
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
		self.permalink = permalink
		self.permalinkURL = permalinkURL
		self.plan = plan
		self.playlistCount = playlistCount
		self.publicFavoritesCount = publicFavoritesCount
		self.repostsCount = repostsCount
		self.trackCount = trackCount
		self.uri = uri
		self.username = username
		self.website = website
		self.websiteTitle = websiteTitle
	}
}
