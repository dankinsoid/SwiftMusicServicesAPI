import SwiftMusicServicesApi
import SwiftAPIClient
import Foundation

public extension YouTube.API {

    var videos: Videos {
        Videos(client: client("videos"))
    }
    
    struct Videos {
        let client: APIClient
    }
}

extension YouTube.API.Videos {
    
    /// Returns a list of videos that match the API request parameters.
    /// For example, you can retrieve all playlists that the authenticated user owns, or you can retrieve one or more playlists by their unique IDs.
    /// - Parameters:
    ///   - filter: Filter
    ///   - hl: The hl parameter instructs the API to retrieve localized resource metadata for a specific application language that the YouTube website supports.
    ///   The parameter value must be a language code included in the list returned by the i18nLanguages.list method.
    ///   If localized resource details are available in that language, the resource's snippet.localized object will contain the localized values.
    ///   However, if localized details are not available, the snippet.localized object will contain resource details in the resource's default language.
    ///   - maxHeight: The maxHeight parameter specifies the maximum height of the embedded player returned in the player.embedHtml property.
    ///   You can use this parameter to specify that instead of the default dimensions, the embed code should use a height appropriate for your application layout.
    ///   If the maxWidth parameter is also provided, the player may be shorter than the maxHeight in order to not violate the maximum width. Acceptable values are 72 to 8192, inclusive.
    ///   - maxWidth: The maxWidth parameter specifies the maximum width of the embedded player returned in the player.embedHtml property.
    ///   You can use this parameter to specify that instead of the default dimensions, the embed code should use a width appropriate for your application layout.
    ///   If the maxHeight parameter is also provided, the player may be narrower than maxWidth in order to not violate the maximum height. Acceptable values are 72 to 8192, inclusive.
    ///   - regionCode: The regionCode parameter instructs the API to select a video chart available in the specified region. This parameter can only be used in conjunction with the chart parameter. The parameter value is an ISO 3166-1 alpha-2 country code.
    ///   - videoCategoryId: The videoCategoryId parameter identifies the video category for which the chart should be retrieved. This parameter can only be used in conjunction with the chart parameter. By default, charts are not restricted to a particular category. The default value is 0.
    ///   - onBehalfOfContentOwner: This parameter can only be used in a properly authorized request. Note: This parameter is intended exclusively for YouTube content partners.
    ///   The onBehalfOfContentOwner parameter indicates that the request's authorization credentials identify a YouTube CMS user who is acting on behalf of the content owner specified in the parameter value.
    ///   This parameter is intended for YouTube content partners that own and manage many different YouTube channels. It allows content owners to authenticate once and get access to all their video and channel data, without having to provide authentication credentials for each individual channel.
    ///   The CMS account that the user authenticates with must be linked to the specified YouTube content owner.
    ///   - part: The part parameter specifies a comma-separated list of one or more playlist resource properties that the API response will include.
    ///   - limit: The maximum number of items that should be returned in the result set. The default value is nil.
    ///   - pageToken: The pageToken parameter identifies a specific page in the result set that should be returned. In an API response, the nextPageToken and prevPageToken properties identify other pages that could be retrieved.
    public func list(
        filter: Filter,
        hl: String? = nil,
        maxHeight: Int? = nil,
        maxWidth: Int? = nil,
        regionCode: String? = nil,
        videoCategoryId: YTO.VideoCategoryID? = nil,
        onBehalfOfContentOwner: String? = nil,
        part: [YTO.Video.CodingKeys],
        limit: Int? = nil,
        pageToken: String? = nil
    ) -> YTPaging<YTO.Video> {
        let filterParams = filter.params
        return YTPaging(
            client: client.query([
                "part": part,
                filterParams.0: filterParams.1,
                "onBehalfOfContentOwner": onBehalfOfContentOwner,
                "hl": hl,
                "maxHeight": maxHeight,
                "maxWidth": maxWidth,
                "regionCode": regionCode,
                "videoCategoryId": videoCategoryId,
            ])
            .auth(enabled: filter.isMyRating || onBehalfOfContentOwner != nil),
            limit: limit,
            pageToken: pageToken
        )
    }
    
    public enum Filter: Codable, Equatable {
        /// The chart parameter identifies the chart that you want to retrieve.
        case chart
        /// The id parameter specifies a list of the YouTube video ID(s) for the resource(s) that are being retrieved. In a video resource, the id property specifies the video's ID.
        case id([String])
        /// This parameter can only be used in a properly authorized request. Set this parameter's value to like or dislike to instruct the API to only return videos liked or disliked by the authenticated user.
        case myRating(YTO.MyRating)
        
        public var params: (String, Encodable) {
            switch self {
            case .chart: return ("chart", "mostPopular")
            case let .id(id): return ("id", id)
            case let .myRating(rating): return ("myRating", rating)
            }
        }
        
        var isMyRating: Bool {
            if case .myRating = self { true } else { false }
        }
    }
}

// TODO: - other methods
