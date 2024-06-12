import SwiftMusicServicesApi
import SwiftAPIClient
import Foundation

public extension YouTube.API {
    
    var search: Search {
        Search(client: client("search"))
    }
    
    struct Search {
        let client: APIClient
    }
}

extension YouTube.API.Search {
    
    /// Returns a collection of search results that match the query parameters specified in the API request.
    /// By default, a search result set identifies matching video, channel, and playlist resources, but you can also configure queries to only retrieve a specific type of resource.
    ///
    /// - Parameters:
    ///   - filter: Filter
    ///   - q: The q parameter specifies the query term to search for. Your request can also use the Boolean NOT (-) and OR (|) operators to exclude videos or to find videos that are associated with one of several search terms.
    ///   - channelId: The channelId parameter indicates that the API response should only contain resources created by the channel.
    ///   - channelType: The channelType parameter lets you restrict a search to a particular type of channel. Acceptable values are:
    ///     - `any` – Return all channels.
    ///     - `show` – Only retrieve shows.
    ///   - eventType: The eventType parameter restricts a search to broadcast events. Acceptable values are:
    ///     - `completed` – Only include completed broadcasts.
    ///     - `live` – Only include active broadcasts.
    ///     - `upcoming` – Only include upcoming broadcasts.
    ///   - location: The location parameter, in conjunction with the locationRadius parameter, defines a circular geographic area and restricts a search to videos that specify a geographic location in their metadata.
    ///   - locationRadius: The locationRadius parameter, in conjunction with the location parameter, defines a circular geographic area.
    ///   - onBehalfOfContentOwner: This parameter can only be used in a properly authorized request. It indicates that the request's authorization credentials identify a YouTube CMS user who is acting on behalf of the content owner specified in the parameter value.
    ///   - order: The order parameter specifies the method that will be used to order resources in the API response. Acceptable values are:
    ///     - `date` – Resources are sorted in reverse chronological order based on the date they were created.
    ///     - `rating` – Resources are sorted from highest to lowest rating.
    ///     - `relevance` – Resources are sorted based on their relevance to the search query. This is the default value for this parameter.
    ///     - `title` – Resources are sorted alphabetically by title.
    ///     - `videoCount` – Channels are sorted in descending order of their number of uploaded videos.
    ///     - `viewCount` – Resources are sorted from highest to lowest number of views.
    ///   - publishedAfter: The publishedAfter parameter indicates that the API response should only contain resources created at or after the specified time. The value is an RFC 3339 formatted date-time value (e.g., 1970-01-01T00:00:00Z).
    ///   - publishedBefore: The publishedBefore parameter indicates that the API response should only contain resources created before or at the specified time. The value is an RFC 3339 formatted date-time value (e.g., 1970-01-01T00:00:00Z).
    ///   - regionCode: The regionCode parameter instructs the API to return search results for videos that can be viewed in the specified country. The parameter value is an ISO 3166-1 alpha-2 country code.
    ///   - relevanceLanguage: The relevanceLanguage parameter instructs the API to return search results that are most relevant to the specified language. The parameter value is typically an ISO 639-1 two-letter language code.
    ///   - safeSearch: The safeSearch parameter indicates whether the search results should include restricted content as well as standard content. Acceptable values are:
    ///     - `moderate` – YouTube will filter some content from search results and, at the least, will filter content that is restricted in your locale.
    ///     - `none` – YouTube will not filter the search result set.
    ///     - `strict` – YouTube will try to exclude all restricted content from the search result set.
    ///   - topicId: The topicId parameter indicates that the API response should only contain resources associated with the specified topic.
    ///   - type: The type parameter restricts a search query to only retrieve a particular type of resource. Acceptable values are:
    ///     - `channel`
    ///     - `playlist`
    ///     - `video`
    ///   - videoCaption: The videoCaption parameter indicates whether the API should filter video search results based on whether they have captions. Acceptable values are:
    ///     - `any` – Do not filter results based on caption availability.
    ///     - `closedCaption` – Only include videos that have captions.
    ///     - `none` – Only include videos that do not have captions.
    ///   - videoCategoryId: The videoCategoryId parameter filters video search results based on their category.
    ///   - videoDefinition: The videoDefinition parameter lets you restrict a search to only include either high definition (HD) or standard definition (SD) videos. Acceptable values are:
    ///     - `any` – Return all videos, regardless of their resolution.
    ///     - `high` – Only retrieve HD videos.
    ///     - `standard` – Only retrieve videos in standard definition.
    ///   - videoDimension: The videoDimension parameter lets you restrict a search to only retrieve 2D or 3D videos. Acceptable values are:
    ///     - `2d` – Restrict search results to exclude 3D videos.
    ///     - `3d` – Restrict search results to only include 3D videos.
    ///     - `any` – Include both 3D and non-3D videos in returned results. This is the default value.
    ///   - videoDuration: The videoDuration parameter filters video search results based on their duration. Acceptable values are:
    ///     - `any` – Do not filter video search results based on their duration.
    ///     - `long` – Only include videos longer than 20 minutes.
    ///     - `medium` – Only include videos that are between four and 20 minutes long (inclusive).
    ///     - `short` – Only include videos that are less than four minutes long.
    ///   - videoEmbeddable: The videoEmbeddable parameter lets you restrict a search to only videos that can be embedded into a webpage. Acceptable values are:
    ///     - `any` – Return all videos, embeddable or not.
    ///     - `true` – Only retrieve embeddable videos.
    ///   - videoLicense: The videoLicense parameter filters search results to only include videos with a particular license. Acceptable values are:
    ///     - `any` – Return all videos, regardless of which license they have.
    ///     - `creativeCommon` – Only return videos that have a Creative Commons license.
    ///     - `youtube` – Only return videos that have the standard YouTube license.
    ///   - videoPaidProductPlacement: The videoPaidProductPlacement parameter filters search results to only include videos that the creator has denoted as having a paid promotion. Acceptable values are:
    ///     - `any` – Return all videos, regardless of whether they contain paid promotions.
    ///     - `true` – Only retrieve videos with paid promotions.
    ///   - videoSyndicated: The videoSyndicated parameter lets you restrict a search to only videos that can be played outside youtube.com. Acceptable values are:
    ///     - `any` – Return all videos, syndicated or not.
    ///     - `true` – Only retrieve syndicated videos.
    ///   - videoType: The videoType parameter lets you restrict a search to a particular type of videos. Acceptable values are:
    ///     - `any` – Return all videos.
    ///     - `episode` – Only retrieve episodes of shows.
    ///     - `movie` – Only retrieve movies.
    ///   - part: The part parameter specifies a comma-separated list of one or more playlist resource properties that the API response will include.
    ///   - limit: The maximum number of items that should be returned in the result set. The default value is nil.
    ///   - pageToken: The pageToken parameter identifies a specific page in the result set that should be returned. In an API response, the nextPageToken and prevPageToken properties identify other pages that could be retrieved.
    public func list(
        filter: Filter? = nil,
        q: String? = nil,
        channelId: String? = nil,
        channelType: YTO.ChannelType? = nil,
        eventType: YTO.EventType? = nil,
        location: String? = nil,
        locationRadius: String? = nil,
        onBehalfOfContentOwner: String? = nil,
        order: YTO.Order? = nil,
        publishedAfter: Date? = nil,
        publishedBefore: Date? = nil,
        regionCode: String? = nil,
        relevanceLanguage: String? = nil,
        safeSearch: YTO.SafeSearch? = nil,
        topicId: String? = nil,
        type: String? = nil,
        videoCaption: YTO.VideoCaption? = nil,
        videoCategoryId: YTO.VideoCategoryID? = nil,
        videoDefinition: YTO.VideoDefinition? = nil,
        videoDimension: YTO.VideoDimension? = nil,
        videoDuration: YTO.VideoDuration? = nil,
        videoEmbeddable: YTO.VideoEmbeddable? = nil,
        videoLicense: YTO.VideoLicense? = nil,
        videoPaidProductPlacement: YTO.VideoPaidProductPlacement? = nil,
        videoSyndicated: YTO.VideoSyndicated? = nil,
        videoType: YTO.VideoType? = nil,
        auth: Bool? = nil,
        part: [YTO.SearchResult.CodingKeys] = [.snippet],
        limit: Int? = nil,
        pageToken: String? = nil
    ) -> YTPaging<YTO.SearchResult> {
        YTPaging<YTO.SearchResult>(
            client: client.query(
                [
                    "part": part,
                    "channelId": channelId,
                    "channelType": channelType,
                    "eventType": eventType,
                    "location": location,
                    "locationRadius": locationRadius,
                    "onBehalfOfContentOwner": onBehalfOfContentOwner,
                    "order": order,
                    "publishedAfter": publishedAfter,
                    "publishedBefore": publishedBefore,
                    "q": q,
                    "regionCode": regionCode,
                    "relevanceLanguage": relevanceLanguage,
                    "safeSearch": safeSearch,
                    "topicId": topicId,
                    "type": videoCategoryId == nil ? type : "video",
                    "videoCaption": videoCaption,
                    "videoCategoryId": videoCategoryId,
                    "videoDefinition": videoDefinition,
                    "videoDimension": videoDimension,
                    "videoDuration": videoDuration,
                    "videoEmbeddable": videoEmbeddable,
                    "videoLicense": videoLicense,
                    "videoPaidProductPlacement": videoPaidProductPlacement,
                    "videoSyndicated": videoSyndicated,
                    "videoType": videoType
                ].merging(
                    filter.map { [$0.rawValue: true as Encodable] } ?? [:]
                ) { _, p in p }
            )
            .auth(enabled: filter != nil || auth == true),
            limit: limit,
            pageToken: pageToken
        )
    }

    /// Represents the various boolean parameters used for filtering YouTube search results.
    public enum Filter: String {
        /// This parameter can only be used in a properly authorized request, and it is intended exclusively for YouTube content partners.
        ///
        /// The forContentOwner parameter restricts the search to only retrieve videos owned by the content owner identified by the onBehalfOfContentOwner parameter. If forContentOwner is set to true, the request must also meet these requirements:
        /// - The onBehalfOfContentOwner parameter is required.
        /// - The user authorizing the request must be using an account linked to the specified content owner.
        /// - The type parameter value must be set to video.
        /// - None of the following other parameters can be set: videoDefinition, videoDimension, videoDuration, videoEmbeddable, videoLicense, videoPaidProductPlacement, videoSyndicated, videoType.
        case forContentOwner
        
        /// This parameter can only be used in a properly authorized request.
        ///
        /// The forDeveloper parameter restricts the search to only retrieve videos uploaded via the developer's application or website. The API server uses the request's authorization credentials to identify the developer. The forDeveloper parameter can be used in conjunction with optional search parameters like the q parameter.
        ///
        /// For this feature, each uploaded video is automatically tagged with the project number that is associated with the developer's application in the Google Developers Console.
        ///
        /// When a search request subsequently sets the forDeveloper parameter to true, the API server uses the request's authorization credentials to identify the developer. Therefore, a developer can restrict results to videos uploaded through the developer's own app or website but not to videos uploaded through other apps or sites.
        case forDeveloper
        
        /// This parameter can only be used in a properly authorized request.
        ///
        /// The forMine parameter restricts the search to only retrieve videos owned by the authenticated user. If you set this parameter to true, then the type parameter's value must also be set to video. In addition, none of the following other parameters can be set in the same request: videoDefinition, videoDimension, videoDuration, videoEmbeddable, videoLicense, videoPaidProductPlacement, videoSyndicated, videoType.
        case forMine
    }
}

extension YouTube.Objects {

    public struct SearchResult: Codable, Equatable {
        public var id: ID?
        public var snippet: Snippet?
        
        public init(id: ID? = nil, snippet: Snippet? = nil) {
            self.id = id
            self.snippet = snippet
        }
        
        public enum CodingKeys: String, CodingKey, Codable, Hashable, CaseIterable {
            case id
            case snippet
        }

        public struct ID: Codable, Hashable {
            public var kind: String?
            public var videoId: String?
            public var channelId: String?
            public var playlistId: String?
            
            public init(kind: String? = nil, videoId: String? = nil, channelId: String? = nil, playlistId: String? = nil) {
                self.kind = kind
                self.videoId = videoId
                self.channelId = channelId
                self.playlistId = playlistId
            }
        }
        
        public struct Snippet: Codable, Equatable {
            public var publishedAt: Date?
            public var channelId: String?
            public var title: String?
            public var description: String?
            public var thumbnails: YTO.Thumbnails?
            public var channelTitle: String?
            public var liveBroadcastContent: String?
            
            public init(publishedAt: Date? = nil, channelId: String? = nil, title: String? = nil, description: String? = nil, thumbnails: YTO.Thumbnails? = nil, channelTitle: String? = nil, liveBroadcastContent: String? = nil) {
                self.publishedAt = publishedAt
                self.channelId = channelId
                self.title = title
                self.description = description
                self.thumbnails = thumbnails
                self.channelTitle = channelTitle
                self.liveBroadcastContent = liveBroadcastContent
            }
        }
    }
    
    public enum ChannelType: String, Codable {
        case any
        case show
    }
    
    public enum EventType: String, Codable {
        case completed
        case live
        case upcoming
    }
    
    public enum Order: String, Codable {
        case date
        case rating
        case relevance
        case title
        case videoCount
        case viewCount
    }
    
    public enum SafeSearch: String, Codable {
        case moderate
        case none
        case strict
    }
    
    public enum VideoCaption: String, Codable {
        case any
        case closedCaption
        case none
    }
    
    public enum VideoDefinition: String, Codable {
        case any
        case high
        case standard
    }
    
    public enum VideoDimension: String, Codable {
        case any
        case d2 = "2d"
        case d3 = "3d"
    }
    
    public enum VideoDuration: String, Codable {
        case any
        case long
        case medium
        case short
    }
    
    public enum VideoEmbeddable: String, Codable {
        case any
        case `true`
    }
    
    public enum VideoLicense: String, Codable {
        case any
        case creativeCommon
        case youtube
    }
    
    public enum VideoPaidProductPlacement: String, Codable {
        case any
        case `true`
    }
    
    public enum VideoSyndicated: String, Codable {
        case any
        case `true`
    }
    
    public enum VideoType: String, Codable {
        case any
        case episode
        case movie
    }
}
