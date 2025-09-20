import Foundation
import SwiftAPIClient
import SwiftMusicServicesApi

public extension YouTube.Objects {

	struct Channel: Codable, Equatable {

		public var id: String?
		public var snippet: Snippet?
		public var contentDetails: ContentDetails?
		public var statistics: Statistics?
		public var topicDetails: TopicDetails?
		public var status: Status?
		public var brandingSettings: BrandingSettings?
		public var auditDetails: AuditDetails?
		public var contentOwnerDetails: ContentOwnerDetails?
		public var localizations: [String: YTO.Localization]?

		public init(
			id: String? = nil,
			snippet: Snippet? = nil,
			contentDetails: ContentDetails? = nil,
			statistics: Statistics? = nil,
			topicDetails: TopicDetails? = nil,
			status: Status? = nil,
			brandingSettings: BrandingSettings? = nil,
			auditDetails: AuditDetails? = nil,
			contentOwnerDetails: ContentOwnerDetails? = nil,
			localizations: [String: YTO.Localization]? = nil
		) {
			self.id = id
			self.snippet = snippet
			self.contentDetails = contentDetails
			self.statistics = statistics
			self.topicDetails = topicDetails
			self.status = status
			self.brandingSettings = brandingSettings
			self.auditDetails = auditDetails
			self.contentOwnerDetails = contentOwnerDetails
			self.localizations = localizations
		}

		public enum CodingKeys: String, CodingKey, Codable {
			case id
			case snippet
			case contentDetails
			case statistics
			case topicDetails
			case status
			case brandingSettings
			case auditDetails
			case contentOwnerDetails
			case localizations
		}

		public struct Snippet: Codable, Equatable {

			public var title: String
			public var description: String?
			public var customUrl: String?
			public var publishedAt: Date?
			public var thumbnails: YTO.Thumbnails?
			public var defaultLanguage: String?
			public var localized: YTO.Localization?
			public var country: CountryCode?

			public init(title: String, description: String? = nil, customUrl: String? = nil, publishedAt: Date? = nil, thumbnails: YTO.Thumbnails? = nil, defaultLanguage: String? = nil, localized: YTO.Localization? = nil, country: CountryCode? = nil) {
				self.title = title
				self.description = description
				self.customUrl = customUrl
				self.publishedAt = publishedAt
				self.thumbnails = thumbnails
				self.defaultLanguage = defaultLanguage
				self.localized = localized
				self.country = country
			}
		}

		public struct ContentDetails: Codable, Equatable {
			public var relatedPlaylists: RelatedPlaylists?

			public init(relatedPlaylists: RelatedPlaylists? = nil) {
				self.relatedPlaylists = relatedPlaylists
			}

			public struct RelatedPlaylists: Codable, Equatable {
				public var likes: String?
				public var favorites: String?
				public var uploads: String?

				public init(likes: String? = nil, favorites: String? = nil, uploads: String? = nil) {
					self.likes = likes
					self.favorites = favorites
					self.uploads = uploads
				}
			}
		}

		public struct Statistics: Codable, Equatable {
			public var viewCount: UInt64?
			public var subscriberCount: UInt64?
			public var hiddenSubscriberCount: Bool?
			public var videoCount: UInt64?

			public init(viewCount: UInt64? = nil, subscriberCount: UInt64? = nil, hiddenSubscriberCount: Bool? = nil, videoCount: UInt64? = nil) {
				self.viewCount = viewCount
				self.subscriberCount = subscriberCount
				self.hiddenSubscriberCount = hiddenSubscriberCount
				self.videoCount = videoCount
			}
		}

		public struct TopicDetails: Codable, Equatable {
			public var topicIds: [String]?
			public var topicCategories: [String]?

			public init(topicIds: [String]? = nil, topicCategories: [String]? = nil) {
				self.topicIds = topicIds
				self.topicCategories = topicCategories
			}
		}

		public struct Status: Codable, Equatable {
			public var privacyStatus: YTO.PrivacyStatus?
			public var isLinked: Bool?
			public var longUploadsStatus: YTO.UploadStatus?
			public var madeForKids: Bool?
			public var selfDeclaredMadeForKids: Bool?

			public init(privacyStatus: YTO.PrivacyStatus? = nil, isLinked: Bool? = nil, longUploadsStatus: YTO.UploadStatus? = nil, madeForKids: Bool? = nil, selfDeclaredMadeForKids: Bool? = nil) {
				self.privacyStatus = privacyStatus
				self.isLinked = isLinked
				self.longUploadsStatus = longUploadsStatus
				self.madeForKids = madeForKids
				self.selfDeclaredMadeForKids = selfDeclaredMadeForKids
			}
		}

		public struct BrandingSettings: Codable, Equatable {
			public var channel: ChannelSettings?
			public var watch: WatchSettings?

			public init(channel: ChannelSettings? = nil, watch: WatchSettings? = nil) {
				self.channel = channel
				self.watch = watch
			}

			public struct ChannelSettings: Codable, Equatable {
				public var title: String?
				public var description: String?
				public var keywords: String?
				public var trackingAnalyticsAccountId: String?
				public var unsubscribedTrailer: String?
				public var defaultLanguage: String?
				public var country: CountryCode?

				public init(title: String? = nil, description: String? = nil, keywords: String? = nil, trackingAnalyticsAccountId: String? = nil, unsubscribedTrailer: String? = nil, defaultLanguage: String? = nil, country: CountryCode? = nil) {
					self.title = title
					self.description = description
					self.keywords = keywords
					self.trackingAnalyticsAccountId = trackingAnalyticsAccountId
					self.unsubscribedTrailer = unsubscribedTrailer
					self.defaultLanguage = defaultLanguage
					self.country = country
				}
			}

			public struct WatchSettings: Codable, Equatable {
				public var textColor: String?
				public var backgroundColor: String?
				public var featuredPlaylistId: String?

				public init(textColor: String? = nil, backgroundColor: String? = nil, featuredPlaylistId: String? = nil) {
					self.textColor = textColor
					self.backgroundColor = backgroundColor
					self.featuredPlaylistId = featuredPlaylistId
				}
			}
		}

		public struct AuditDetails: Codable, Equatable {
			public var overallGoodStanding: Bool?
			public var communityGuidelinesGoodStanding: Bool?
			public var copyrightStrikesGoodStanding: Bool?
			public var contentIdClaimsGoodStanding: Bool?

			public init(overallGoodStanding: Bool? = nil, communityGuidelinesGoodStanding: Bool? = nil, copyrightStrikesGoodStanding: Bool? = nil, contentIdClaimsGoodStanding: Bool? = nil) {
				self.overallGoodStanding = overallGoodStanding
				self.communityGuidelinesGoodStanding = communityGuidelinesGoodStanding
				self.copyrightStrikesGoodStanding = copyrightStrikesGoodStanding
				self.contentIdClaimsGoodStanding = contentIdClaimsGoodStanding
			}
		}

		public struct ContentOwnerDetails: Codable, Equatable {
			public var contentOwner: String?
			public var timeLinked: Date?

			public init(contentOwner: String? = nil, timeLinked: Date? = nil) {
				self.contentOwner = contentOwner
				self.timeLinked = timeLinked
			}
		}
	}
}

extension YouTube.Objects.Channel.Snippet: Mockable {
	public static let mock = YouTube.Objects.Channel.Snippet(
		title: "Mock Channel",
		description: "This is a mock YouTube channel for testing purposes",
		customUrl: "@mockchannel",
		publishedAt: Date(timeIntervalSince1970: 1577836800), // Jan 1, 2020
		thumbnails: YouTube.Objects.Thumbnails.mock,
		defaultLanguage: "en",
		localized: YTO.Localization.mock,
		country: .US
	)
}

extension YouTube.Objects.Channel.ContentDetails.RelatedPlaylists: Mockable {
	public static let mock = YouTube.Objects.Channel.ContentDetails.RelatedPlaylists(
		likes: "PLmock_likes_playlist_id",
		favorites: "PLmock_favorites_playlist_id",
		uploads: "PLmock_uploads_playlist_id"
	)
}

extension YouTube.Objects.Channel.ContentDetails: Mockable {
	public static let mock = YouTube.Objects.Channel.ContentDetails(
		relatedPlaylists: YouTube.Objects.Channel.ContentDetails.RelatedPlaylists.mock
	)
}

extension YouTube.Objects.Channel.Statistics: Mockable {
	public static let mock = YouTube.Objects.Channel.Statistics(
		viewCount: 15_487_932,
		subscriberCount: 1_234_567,
		hiddenSubscriberCount: false,
		videoCount: 342
	)
}

extension YouTube.Objects.Channel.TopicDetails: Mockable {
	public static let mock = YouTube.Objects.Channel.TopicDetails(
		topicIds: ["/m/04rlf", "/m/02mscn"],
		topicCategories: ["https://en.wikipedia.org/wiki/Music", "https://en.wikipedia.org/wiki/Entertainment"]
	)
}

extension YouTube.Objects.Channel.Status: Mockable {
	public static let mock = YouTube.Objects.Channel.Status(
		privacyStatus: YTO.PrivacyStatus.public,
		isLinked: true,
		longUploadsStatus: YTO.UploadStatus.processed,
		madeForKids: false,
		selfDeclaredMadeForKids: false
	)
}

extension YouTube.Objects.Channel.BrandingSettings.ChannelSettings: Mockable {
	public static let mock = YouTube.Objects.Channel.BrandingSettings.ChannelSettings(
		title: "Mock Channel",
		description: "This is a mock channel for testing purposes",
		keywords: "mock testing youtube channel",
		trackingAnalyticsAccountId: "UA-123456789-1",
		unsubscribedTrailer: "mock_trailer_video_id",
		defaultLanguage: "en",
		country: .US
	)
}

extension YouTube.Objects.Channel.BrandingSettings.WatchSettings: Mockable {
	public static let mock = YouTube.Objects.Channel.BrandingSettings.WatchSettings(
		textColor: "#FFFFFF",
		backgroundColor: "#000000",
		featuredPlaylistId: "PLmock_featured_playlist_id"
	)
}

extension YouTube.Objects.Channel.BrandingSettings: Mockable {
	public static let mock = YouTube.Objects.Channel.BrandingSettings(
		channel: YouTube.Objects.Channel.BrandingSettings.ChannelSettings.mock,
		watch: YouTube.Objects.Channel.BrandingSettings.WatchSettings.mock
	)
}

extension YouTube.Objects.Channel.AuditDetails: Mockable {
	public static let mock = YouTube.Objects.Channel.AuditDetails(
		overallGoodStanding: true,
		communityGuidelinesGoodStanding: true,
		copyrightStrikesGoodStanding: true,
		contentIdClaimsGoodStanding: true
	)
}

extension YouTube.Objects.Channel.ContentOwnerDetails: Mockable {
	public static let mock = YouTube.Objects.Channel.ContentOwnerDetails(
		contentOwner: "MockContentNetwork",
		timeLinked: Date(timeIntervalSince1970: 1609459200) // Jan 1, 2021
	)
}

extension YouTube.Objects.Channel: Mockable {
	public static let mock = YouTube.Objects.Channel(
		id: "UCmock_channel_id",
		snippet: YouTube.Objects.Channel.Snippet.mock,
		contentDetails: YouTube.Objects.Channel.ContentDetails.mock,
		statistics: YouTube.Objects.Channel.Statistics.mock,
		topicDetails: YouTube.Objects.Channel.TopicDetails.mock,
		status: YouTube.Objects.Channel.Status.mock,
		brandingSettings: YouTube.Objects.Channel.BrandingSettings.mock,
		auditDetails: YouTube.Objects.Channel.AuditDetails.mock,
		contentOwnerDetails: YouTube.Objects.Channel.ContentOwnerDetails.mock,
		localizations: ["en": YTO.Localization.mock, "es": YTO.Localization(title: "Canal Mock", description: "Descripción del canal mock")]
	)
}
