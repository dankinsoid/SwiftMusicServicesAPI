import Foundation
import SwiftAPIClient

/** Soundcloud Playlist Object */
public struct Playlist: Codable, Equatable {

	/** URL to a JPEG image. */
	public var artworkURL: String?
	/** Created timestamp. */
	public var createdAt: String?
	/** Playlist description. */
	public var description: String?
	/** is downloadable. */
	public var downloadable: Bool?
	/** Playlist duration. */
	public var duration: Int?
	/** European Article Number. */
	public var ean: String?
	/** Embeddable by. */
	public var embeddableBy: String?
	/** Playlist genre. */
	public var genre: String?
	/** Playlist identifier. */
	public var id: Int?
	/** Type of Soundcloud object (playlist). */
	public var kind: String?
	public var label: Label?
	/** Label user identifier. */
	public var labelId: Int?
	/** Label name. */
	public var labelName: String?
	/** Last modified timestamp. */
	public var lastModified: String?
	/** License. */
	public var license: String?
	/** Count of playlist likes. */
	public var likesCount: Int?
	/** Playlist permalink. */
	public var permalink: String?
	/** Playlist permalink URL. */
	public var permalinkURL: String?
	/** Type of playlist. */
	public var playlistType: String?
	/** Purchase title. */
	public var purchaseTitle: String?
	/** Purchase URL. */
	public var purchaseURL: String?
	/** Release. */
	public var release: String?
	/** Day of release. */
	public var releaseDay: Int?
	/** Month of release. */
	public var releaseMonth: Int?
	/** Year of release. */
	public var releaseYear: Int?
	/** Type of sharing (private/public). */
	public var sharing: String?
	/** Is streamable. */
	public var streamable: Bool?
	/** Tags. */
	public var tagList: String?
	/** Tags. */
	public var tags: String?
	/** Playlist title. */
	public var title: String?
	/** Count of tracks. */
	public var trackCount: Int?
	/** List of tracks. */
	public var tracks: [Track]?
	/** tracks URI. */
	public var tracksUri: String?
	/** Playlist type. */
	public var type: String?
	/** Playlist URI. */
	public var uri: String?
	public var user: User?
	/** User identifier. */
	public var userId: Int?

	public enum CodingKeys: String, CodingKey {

		case artworkURL = "artwork_url"
		case createdAt = "created_at"
		case description
		case downloadable
		case duration
		case ean
		case embeddableBy = "embeddable_by"
		case genre
		case id
		case kind
		case label
		case labelId = "label_id"
		case labelName = "label_name"
		case lastModified = "last_modified"
		case license
		case likesCount = "likes_count"
		case permalink
		case permalinkURL = "permalink_url"
		case playlistType = "playlist_type"
		case purchaseTitle = "purchase_title"
		case purchaseURL = "purchase_url"
		case release
		case releaseDay = "release_day"
		case releaseMonth = "release_month"
		case releaseYear = "release_year"
		case sharing
		case streamable
		case tagList = "tag_list"
		case tags
		case title
		case trackCount = "track_count"
		case tracks
		case tracksUri = "tracks_uri"
		case type
		case uri
		case user
		case userId = "user_id"
	}

	public init(
		artworkURL: String? = nil,
		createdAt: String? = nil,
		description: String? = nil,
		downloadable: Bool? = nil,
		duration: Int? = nil,
		ean: String? = nil,
		embeddableBy: String? = nil,
		genre: String? = nil,
		id: Int? = nil,
		kind: String? = nil,
		label: Label? = nil,
		labelId: Int? = nil,
		labelName: String? = nil,
		lastModified: String? = nil,
		license: String? = nil,
		likesCount: Int? = nil,
		permalink: String? = nil,
		permalinkURL: String? = nil,
		playlistType: String? = nil,
		purchaseTitle: String? = nil,
		purchaseURL: String? = nil,
		release: String? = nil,
		releaseDay: Int? = nil,
		releaseMonth: Int? = nil,
		releaseYear: Int? = nil,
		sharing: String? = nil,
		streamable: Bool? = nil,
		tagList: String? = nil,
		tags: String? = nil,
		title: String? = nil,
		trackCount: Int? = nil,
		tracks: [Track]? = nil,
		tracksUri: String? = nil,
		type: String? = nil,
		uri: String? = nil,
		user: User? = nil,
		userId: Int? = nil
	) {
		self.artworkURL = artworkURL
		self.createdAt = createdAt
		self.description = description
		self.downloadable = downloadable
		self.duration = duration
		self.ean = ean
		self.embeddableBy = embeddableBy
		self.genre = genre
		self.id = id
		self.kind = kind
		self.label = label
		self.labelId = labelId
		self.labelName = labelName
		self.lastModified = lastModified
		self.license = license
		self.likesCount = likesCount
		self.permalink = permalink
		self.permalinkURL = permalinkURL
		self.playlistType = playlistType
		self.purchaseTitle = purchaseTitle
		self.purchaseURL = purchaseURL
		self.release = release
		self.releaseDay = releaseDay
		self.releaseMonth = releaseMonth
		self.releaseYear = releaseYear
		self.sharing = sharing
		self.streamable = streamable
		self.tagList = tagList
		self.tags = tags
		self.title = title
		self.trackCount = trackCount
		self.tracks = tracks
		self.tracksUri = tracksUri
		self.type = type
		self.uri = uri
		self.user = user
		self.userId = userId
	}

	/** Soundcloud Playlist Object */
	public struct Label: Codable, Equatable {

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
}
