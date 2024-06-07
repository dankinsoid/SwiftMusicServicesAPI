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
    ///   - filter: Filter
    ///   - hl: The hl parameter instructs the API to retrieve localized resource metadata for a specific application language that the YouTube website supports.
    ///   The parameter value must be a language code included in the list returned by the i18nLanguages.list method.
    ///   If localized resource details are available in that language, the resource's snippet.localized object will contain the localized values.
    ///   However, if localized details are not available, the snippet.localized object will contain resource details in the resource's default language.
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
    ///   - part: The part parameter specifies a comma-separated list of one or more playlist resource properties that the API response will include.
    ///   - limit: The maximum number of items that should be returned in the result set. The default value is nil.
    ///   - pageToken: The pageToken parameter identifies a specific page in the result set that should be returned. In an API response, the nextPageToken and prevPageToken properties identify other pages that could be retrieved.
    public func list(
        filter: Filter,
        hl: String? = nil,
        onBehalfOfContentOwner: String? = nil,
        onBehalfOfContentOwnerChannel: String? = nil,
        part: [YTMO.Playlist.CodingKeys],
        limit: Int? = nil,
        pageToken: String? = nil
    ) -> YTPaging<YTMO.Playlist> {
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

extension YouTube.Music.API.Playlists {
    
    /// Creates a playlist.
    ///
    ///  Requires one of scopes:
    ///  - https://www.googleapis.com/auth/youtubepartner
    ///  - https://www.googleapis.com/auth/youtube
    ///  - https://www.googleapis.com/auth/youtube.force-ssl
    ///
    /// - Parameters:
    ///   - title: Title of the playlist. `snippet.title.`
    ///   - description: Description of the playlist. `snippet.description`
    ///   - privacyStatus: Private status of the playlist. `status.privacyStatus`
    ///   - defaultLanguage: Default language of the playlist. `snippet.defaultLanguage`
    ///   - localizations: Localizations for the playlist. `snippet.localizations`
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
    ///   - part: The part parameter specifies a comma-separated list of one or more playlist resource properties that the API response will include.
    @discardableResult
    public func insert(
        title: String,
        description: String? = nil,
        privacyStatus: YTMO.PrivacyStatus? = nil,
        defaultLanguage: String? = nil,
        localizations: [String: YTMO.Localization]? = nil,
        onBehalfOfContentOwner: String? = nil,
        onBehalfOfContentOwnerChannel: String? = nil,
        part: [YTMO.Playlist.CodingKeys]
    ) async throws -> YTMO.Playlist {
        try await client
            .query([
                "part": part,
                "onBehalfOfContentOwner": onBehalfOfContentOwner,
                "onBehalfOfContentOwnerChannel": onBehalfOfContentOwnerChannel
            ])
            .body(
                YTMO.Playlist(
                    snippet: YTMO.Playlist.Snippet(
                        title: title,
                        description: description,
                        defaultLanguage: defaultLanguage
                    ),
                    status: privacyStatus.map {
                        .init(privacyStatus: $0)
                    },
                    localizations: localizations
                )
            )
            .post()
    }
}

extension YouTube.Music.API.Playlists {

    /// Modifies a playlist. For example, you could change a playlist's title, description, or privacy status.
    ///
    ///  Requires one of scopes:
    ///  - https://www.googleapis.com/auth/youtubepartner
    ///  - https://www.googleapis.com/auth/youtube
    ///  - https://www.googleapis.com/auth/youtube.force-ssl
    ///
    /// - Parameters:
    ///   - playlist: Updated playlist
    ///   - onBehalfOfContentOwner: This parameter can only be used in a properly authorized request. Note: This parameter is intended exclusively for YouTube content partners.
    ///   The onBehalfOfContentOwner parameter indicates that the request's authorization credentials identify a YouTube CMS user who is acting on behalf of the content owner specified in the parameter value.
    ///   This parameter is intended for YouTube content partners that own and manage many different YouTube channels. It allows content owners to authenticate once and get access to all their video and channel data, without having to provide authentication credentials for each individual channel.
    ///   The CMS account that the user authenticates with must be linked to the specified YouTube content owner.
    ///   - part: The part parameter specifies a comma-separated list of one or more playlist resource properties that the API response will include.
    @discardableResult
    public func update(
        playlist: YTMO.Playlist,
        onBehalfOfContentOwner: String? = nil,
        part: [YTMO.Playlist.CodingKeys]
    ) async throws -> YTMO.Playlist {
        try await update(
            id: playlist.id.unwrap(throwing: AnyError("id must be provided")),
            title: playlist.snippet.unwrap(throwing: AnyError("title must be provided")).title,
            description: playlist.snippet?.description,
            privacyStatus: playlist.status?.privacyStatus,
            defaultLanguage: playlist.snippet?.defaultLanguage,
            localizations: playlist.localizations,
            onBehalfOfContentOwner: onBehalfOfContentOwner,
            part: part
        )
    }

    /// Modifies a playlist. For example, you could change a playlist's title, description, or privacy status.
    ///
    ///  Requires one of scopes:
    ///  - https://www.googleapis.com/auth/youtubepartner
    ///  - https://www.googleapis.com/auth/youtube
    ///  - https://www.googleapis.com/auth/youtube.force-ssl
    ///
    /// - Parameters:
    ///   - id: Identifietr of the playlist.
    ///   - title: Title of the playlist. `snippet.title.`
    ///   - description: Description of the playlist. `snippet.description`
    ///   - privacyStatus: Private status of the playlist. `status.privacyStatus`
    ///   - defaultLanguage: Default language of the playlist. `snippet.defaultLanguage`
    ///   - localizations: Localizations for the playlist. `snippet.localizations`
    ///   - onBehalfOfContentOwner: This parameter can only be used in a properly authorized request. Note: This parameter is intended exclusively for YouTube content partners.
    ///   The onBehalfOfContentOwner parameter indicates that the request's authorization credentials identify a YouTube CMS user who is acting on behalf of the content owner specified in the parameter value.
    ///   This parameter is intended for YouTube content partners that own and manage many different YouTube channels. It allows content owners to authenticate once and get access to all their video and channel data, without having to provide authentication credentials for each individual channel.
    ///   The CMS account that the user authenticates with must be linked to the specified YouTube content owner.
    ///   - part: The part parameter specifies a comma-separated list of one or more playlist resource properties that the API response will include.   
    @discardableResult
    public func update(
        id: String,
        title: String,
        description: String? = nil,
        privacyStatus: YTMO.PrivacyStatus? = nil,
        defaultLanguage: String? = nil,
        localizations: [String: YTMO.Localization]? = nil,
        onBehalfOfContentOwner: String? = nil,
        part: [YTMO.Playlist.CodingKeys]
    ) async throws -> YTMO.Playlist {
        try await client
            .query([
                "part": part,
                "onBehalfOfContentOwner": onBehalfOfContentOwner
            ])
            .body(
                YTMO.Playlist(
                    id: id,
                    snippet: YTMO.Playlist.Snippet(
                        title: title,
                        description: description,
                        defaultLanguage: defaultLanguage
                    ),
                    status: privacyStatus.map {
                        .init(privacyStatus: $0)
                    },
                    localizations: localizations
                )
            )
            .put()
    }
}

extension YouTube.Music.API.Playlists {

    /// Deletes a playlist.
    ///
    ///  Requires one of scopes:
    ///  - https://www.googleapis.com/auth/youtubepartner
    ///  - https://www.googleapis.com/auth/youtube
    ///  - https://www.googleapis.com/auth/youtube.force-ssl
    ///
    /// - Parameters:
    ///   - id: Identifietr of the playlist.
    ///   - onBehalfOfContentOwner: This parameter can only be used in a properly authorized request. Note: This parameter is intended exclusively for YouTube content partners.
    ///   The onBehalfOfContentOwner parameter indicates that the request's authorization credentials identify a YouTube CMS user who is acting on behalf of the content owner specified in the parameter value.
    ///   This parameter is intended for YouTube content partners that own and manage many different YouTube channels. It allows content owners to authenticate once and get access to all their video and channel data, without having to provide authentication credentials for each individual channel.
    ///   The CMS account that the user authenticates with must be linked to the specified YouTube content owner.
    public func delete(
        id: String,
        onBehalfOfContentOwner: String? = nil
    ) async throws {
        try await client
            .query([
                "id": id,
                "onBehalfOfContentOwner": onBehalfOfContentOwner
            ])
            .delete()
    }
}

extension YouTube.Music.Objects {

    public struct Playlist: Codable, Equatable {

        public var id: String?
        public var snippet: Snippet?
        public var contentDetails: ContentDetails?
        public var player: Player?
        public var status: Status?
        public var localizations: [String: YTMO.Localization]?

        public enum CodingKeys: String, CodingKey, CaseIterable, Codable {
            case id
            case contentDetails
            case localizations
            case player
            case status
            case snippet
        }
        
        public init(id: String? = nil, snippet: Snippet? = nil, contentDetails: ContentDetails? = nil, player: Player? = nil, status: Status? = nil, localizations: [String: YTMO.Localization]? = nil) {
            self.id = id
            self.snippet = snippet
            self.contentDetails = contentDetails
            self.player = player
            self.status = status
            self.localizations = localizations
        }
    
        public struct Snippet: Codable, Equatable {
    
            public var publishedAt: Date?
            public var channelId: String?
            public var title: String
            public var description: String?
            public var thumbnails: YTMO.Thumbnails?
            public var channelTitle: String?
            public var localized: YTMO.Localization?
            public var defaultLanguage: String?
    
            public init(publishedAt: Date? = nil, channelId: String? = nil, title: String, description: String? = nil, thumbnails: YTMO.Thumbnails? = nil, channelTitle: String? = nil, localized: YTMO.Localization? = nil, defaultLanguage: String? = nil) {
                self.publishedAt = publishedAt
                self.channelId = channelId
                self.title = title
                self.description = description
                self.thumbnails = thumbnails
                self.channelTitle = channelTitle
                self.localized = localized
                self.defaultLanguage = defaultLanguage
            }
        }
        
        public struct Status: Codable, Equatable {

            public var privacyStatus: YTMO.PrivacyStatus
            
            public init(privacyStatus: YTMO.PrivacyStatus) {
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
