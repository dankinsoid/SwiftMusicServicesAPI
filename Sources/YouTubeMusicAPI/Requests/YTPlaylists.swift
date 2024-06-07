import SwiftMusicServicesApi
import SwiftAPIClient
import Foundation

public extension YouTube.Music.API {
    
    var playlists: Playlists {
        Playlists(client: client("playlists"))
    }
    
    struct Playlists {
        let client: APIClient
    }
}

extension YouTube.Music.API.Playlists {

    /// Returns a collection of playlists that match the API request parameters.
    /// For example, you can retrieve all playlists that the authenticated user owns, or you can retrieve one or more playlists by their unique IDs.
    /// - Parameters:
    ///   - part: The part parameter specifies a comma-separated list of one or more playlist resource properties that the API response will include.
    ///   - filter: Filter
    ///   - hl: The hl parameter instructs the API to retrieve localized resource metadata for a specific application language that the YouTube website supports.
    ///   The parameter value must be a language code included in the list returned by the i18nLanguages.list method.
    ///   If localized resource details are available in that language, the resource's snippet.localized object will contain the localized values.
    ///   However, if localized details are not available, the snippet.localized object will contain resource details in the resource's default language.
    ///   - limit: The maximum number of items that should be returned in the result set. The default value is nil.
    ///   - onBehalfOfContentOwner: This parameter can only be used in a properly authorized request. Note: This parameter is intended exclusively for YouTube content partners.
    ///   The onBehalfOfContentOwner parameter indicates that the request's authorization credentials identify a YouTube CMS user who is acting on behalf of the content owner specified in the parameter value.
    ///   This parameter is intended for YouTube content partners that own and manage many different YouTube channels. It allows content owners to authenticate once and get access to all their video and channel data, without having to provide authentication credentials for each individual channel.
    ///   The CMS account that the user authenticates with must be linked to the specified YouTube content owner.
    ///   - onBehalfOfContentOwnerChannel: This parameter can only be used in a properly authorized request.
    ///   Note: This parameter is intended exclusively for YouTube content partners.
    ///   The onBehalfOfContentOwnerChannel parameter specifies the YouTube channel ID of the channel to which a video is being added.
    ///   This parameter is required when a request specifies a value for the onBehalfOfContentOwner parameter, and it can only be used in conjunction with that parameter. In addition, the request must be authorized using a CMS account that is linked to the content owner that the onBehalfOfContentOwner parameter specifies.
    ///   Finally, the channel that the onBehalfOfContentOwnerChannel parameter value specifies must be linked to the content owner that the onBehalfOfContentOwner parameter specifies.
    ///   This parameter is intended for YouTube content partners that own and manage many different YouTube channels.
    ///   It allows content owners to authenticate once and perform actions on behalf of the channel specified in the parameter value, without having to provide authentication credentials for each separate channel.
    ///   - pageToken: The pageToken parameter identifies a specific page in the result set that should be returned. In an API response, the nextPageToken and prevPageToken properties identify other pages that could be retrieved.
    public func list(
        part: [YTMO.Playlist.CodingKeys],
        filter: Filter,
        hl: String? = nil,
        limit: Int? = nil,
        onBehalfOfContentOwner: String? = nil,
        onBehalfOfContentOwnerChannel: String? = nil,
        pageToken: String? = nil
    ) async throws -> YTPaging<YTMO.Playlist> {
        let filterParams = filter.params
        return YTPaging(
            client: client.query([
                "part": part,
                filterParams.0: filterParams.1,
                "onBehalfOfContentOwner": onBehalfOfContentOwner,
                "onBehalfOfContentOwnerChannel": onBehalfOfContentOwnerChannel
            ])
            .auth(enabled: filter == .mine),
            limit: limit,
            pageToken: pageToken
        )
    }

    public enum Filter: Codable, Equatable {
        /// This value indicates that the API should only return the specified channel's playlists.
        case channelId(String)
        /// The id parameter specifies a comma-separated list of the YouTube playlist ID(s) for the resource(s) that are being retrieved. In a playlist resource, the id property specifies the playlist's YouTube playlist ID.
        case id([String])
        /// Playlists owned by the authenticated user.
        case mine

        public var params: (String, Encodable) {
            switch self {
            case let .channelId(id): return ("channelId", id)
            case let .id(id): return ("id", id)
            case .mine: return ("mine", true)
            }
        }
    }
}

extension YouTube.Music.Objects {
    
    public struct Playlist: Codable, Equatable {
        
        public var id: String?
        public var contentDetails: ContentDetails?
        public var localizations: [String]?
        public var player: String?
        public var status: String?

        public enum CodingKeys: String, CodingKey, CaseIterable, Codable {
            case id
            case contentDetails
            case localizations
            case player
            case status
        }
        
        public init(id: String? = nil, contentDetails: ContentDetails? = nil, localizations: [String]? = nil, player: String? = nil, status: String? = nil) {
            self.id = id
            self.contentDetails = contentDetails
            self.localizations = localizations
            self.player = player
            self.status = status
        }
        
        public struct Snippet: Codable, Equatable {
    
            public var publishedAt: Date
            public var channelId: String
            public var title: String
            public var description: String
            public var thumbnails: YTMO.Thumbnails
            public var channelTitle: String
            public var localized: Localized?
    
            public struct Localized: Codable, Equatable {
    
                public var title: String
                public var description: String?
                
                public init(title: String, description: String? = nil) {
                    self.title = title
                    self.description = description
                }
            }

            public init(publishedAt: Date, channelId: String, title: String, description: String, thumbnails: YTMO.Thumbnails, channelTitle: String, localized: Localized? = nil) {
                self.publishedAt = publishedAt
                self.channelId = channelId
                self.title = title
                self.description = description
                self.thumbnails = thumbnails
                self.channelTitle = channelTitle
                self.localized = localized
            }
        }
        
        public struct Status: Codable, Equatable {

            public var privacyStatus: String
            
            public init(privacyStatus: String) {
                self.privacyStatus = privacyStatus
            }
        }
        
        public struct ContentDetails: Codable, Equatable {

            public var itemCount: Int
            
            public init(itemCount: Int) {
                self.itemCount = itemCount
            }
        }
    }
}
