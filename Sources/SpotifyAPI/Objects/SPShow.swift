public struct SPShow: Codable {
   ///A list of the countries in which the show can be played, identified by their [ISO 3166-1 alpha-2](http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) code.
   public var availableMarkets: [String]
   ///The copyright statements of the show.
   public var copyrights: [SPCopyright]?
   ///A description of the show.
   public var description: String
   ///Whether or not the show has explicit content (true = yes it does; false = no it does not OR unknown).
   public var explicit: Bool
   ///A list of the show's episodes.
   public var episodes: [SPEpisode]?
   ///Known external URLs for this show.
   public var externalUrls: SPExternalURL?
   ///A link to the Web API endpoint providing full details of the show.
   public var href: String
   ///The [Spotify ID](/documentation/web-api/#spotify-uris-and-ids) for the show.
   public var id: String
   ///The cover art for the show in various sizes, widest first.
   public var images: [SPImage]?
   ///True if all of the show's episodes are hosted outside of Spotify's CDN. This field might be null in some cases.
   public var isExternallyHosted: Bool?
   ///A list of the languages used in the show, identified by their [ISO 639](https://en.wikipedia.org/wiki/ISO_639) code.
   public var languages: [String]?
   ///The media type of the show.
   public var mediaType: String
   ///The name of the show.
   public var name: String
   ///The publisher of the show.
   public var publisher: String
   ///The object type: "show".
   public var type: String
   ///The [Spotify URI](/documentation/web-api/#spotify-uris-and-ids) for the show.
   public var uri: String
    
    public init(availableMarkets: [String], copyrights: [SPCopyright]? = nil, description: String, explicit: Bool, episodes: [SPEpisode]? = nil, externalUrls: SPExternalURL? = nil, href: String, id: String, images: [SPImage]? = nil, isExternallyHosted: Bool? = nil, languages: [String]? = nil, mediaType: String, name: String, publisher: String, type: String, uri: String) {
        self.availableMarkets = availableMarkets
        self.copyrights = copyrights
        self.description = description
        self.explicit = explicit
        self.episodes = episodes
        self.externalUrls = externalUrls
        self.href = href
        self.id = id
        self.images = images
        self.isExternallyHosted = isExternallyHosted
        self.languages = languages
        self.mediaType = mediaType
        self.name = name
        self.publisher = publisher
        self.type = type
        self.uri = uri
    }
}
