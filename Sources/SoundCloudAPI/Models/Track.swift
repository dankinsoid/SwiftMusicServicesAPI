import Foundation
import SwiftAPIClient

/** Soundcloud Track object. */
public struct Track: Codable, Equatable {

	/** Level of access the user (logged in or anonymous) has to the track.
	  * `playable` - user is allowed to listen to a full track.
	  * `preview` - user is allowed to preview a track, meaning a snippet is available
	  * `blocked` - user can only see the metadata of a track, no streaming is possible
	 */
	public var access: Access?
	/** URL to a JPEG image. */
	public var artworkURL: String?
	/** List of countries where track is available. */
	public var availableCountryCodes: String?
	/** Tempo. */
	public var bpm: Int?
	/** Number of comments. */
	public var commentCount: Int?
	/** Is commentable. */
	public var commentable: Bool?
	/** Created timestamp. */
	public var createdAt: String?
	/** Track description. */
	public var description: String?
	/** NUmber of downloads. */
	public var downloadCount: Int?
	/** URL to download a track. */
	public var downloadURL: String?
	/** Is downloadable. */
	public var downloadable: String?
	/** Track duration. */
	public var duration: Int?
	/** Number of favoritings. */
	public var favoritingsCount: Int?
	/** Genre */
	public var genre: String?
	/** Track identifier. */
	public var id: Int?
	/** ISRC code. */
	public var isrc: String?
	/** Key signature. */
	public var keySignature: String?
	/** Type of object (track). */
	public var kind: String?
	/** Label user name. */
	public var labelName: String?
	/** License */
	public var license: String?
	/** Permalink URL. */
	public var permalinkURL: String?
	/** Number of plays. */
	public var playbackCount: Int?
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
	/** Number of reposts. */
	public var repostsCount: Int?
	/** Secret URL. */
	public var secretUri: String?
	/** Type of sharing (public/private). */
	public var sharing: String?
	/** URL to stream. */
	public var streamURL: String?
	/** Is streamable. */
	public var streamable: Bool?
	/** Tags. */
	public var tagList: String?
	/** Track title. */
	public var title: String?
	/** Track URI. */
	public var uri: String?
	public var user: User?
	/** Is user's favourite. */
	public var userFavorite: Bool?
	/** Number of plays by a user. */
	public var userPlaybackCount: Int?
	/** Waveform URL. */
	public var waveformURL: String?

	public enum CodingKeys: String, CodingKey {

		case access
		case artworkURL = "artwork_url"
		case availableCountryCodes = "available_country_codes"
		case bpm
		case commentCount = "comment_count"
		case commentable
		case createdAt = "created_at"
		case description
		case downloadCount = "download_count"
		case downloadURL = "download_url"
		case downloadable
		case duration
		case favoritingsCount = "favoritings_count"
		case genre
		case id
		case isrc
		case keySignature = "key_signature"
		case kind
		case labelName = "label_name"
		case license
		case permalinkURL = "permalink_url"
		case playbackCount = "playback_count"
		case purchaseTitle = "purchase_title"
		case purchaseURL = "purchase_url"
		case release
		case releaseDay = "release_day"
		case releaseMonth = "release_month"
		case releaseYear = "release_year"
		case repostsCount = "reposts_count"
		case secretUri = "secret_uri"
		case sharing
		case streamURL = "stream_url"
		case streamable
		case tagList = "tag_list"
		case title
		case uri
		case user
		case userFavorite = "user_favorite"
		case userPlaybackCount = "user_playback_count"
		case waveformURL = "waveform_url"
	}

	public init(
		access: Access? = nil,
		artworkURL: String? = nil,
		availableCountryCodes: String? = nil,
		bpm: Int? = nil,
		commentCount: Int? = nil,
		commentable: Bool? = nil,
		createdAt: String? = nil,
		description: String? = nil,
		downloadCount: Int? = nil,
		downloadURL: String? = nil,
		downloadable: String? = nil,
		duration: Int? = nil,
		favoritingsCount: Int? = nil,
		genre: String? = nil,
		id: Int? = nil,
		isrc: String? = nil,
		keySignature: String? = nil,
		kind: String? = nil,
		labelName: String? = nil,
		license: String? = nil,
		permalinkURL: String? = nil,
		playbackCount: Int? = nil,
		purchaseTitle: String? = nil,
		purchaseURL: String? = nil,
		release: String? = nil,
		releaseDay: Int? = nil,
		releaseMonth: Int? = nil,
		releaseYear: Int? = nil,
		repostsCount: Int? = nil,
		secretUri: String? = nil,
		sharing: String? = nil,
		streamURL: String? = nil,
		streamable: Bool? = nil,
		tagList: String? = nil,
		title: String? = nil,
		uri: String? = nil,
		user: User? = nil,
		userFavorite: Bool? = nil,
		userPlaybackCount: Int? = nil,
		waveformURL: String? = nil
	) {
		self.access = access
		self.artworkURL = artworkURL
		self.availableCountryCodes = availableCountryCodes
		self.bpm = bpm
		self.commentCount = commentCount
		self.commentable = commentable
		self.createdAt = createdAt
		self.description = description
		self.downloadCount = downloadCount
		self.downloadURL = downloadURL
		self.downloadable = downloadable
		self.duration = duration
		self.favoritingsCount = favoritingsCount
		self.genre = genre
		self.id = id
		self.isrc = isrc
		self.keySignature = keySignature
		self.kind = kind
		self.labelName = labelName
		self.license = license
		self.permalinkURL = permalinkURL
		self.playbackCount = playbackCount
		self.purchaseTitle = purchaseTitle
		self.purchaseURL = purchaseURL
		self.release = release
		self.releaseDay = releaseDay
		self.releaseMonth = releaseMonth
		self.releaseYear = releaseYear
		self.repostsCount = repostsCount
		self.secretUri = secretUri
		self.sharing = sharing
		self.streamURL = streamURL
		self.streamable = streamable
		self.tagList = tagList
		self.title = title
		self.uri = uri
		self.user = user
		self.userFavorite = userFavorite
		self.userPlaybackCount = userPlaybackCount
		self.waveformURL = waveformURL
	}

	/** Soundcloud Track object. */
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
}
