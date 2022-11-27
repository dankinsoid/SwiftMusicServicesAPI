public struct SPAlbum: Codable {
   ///The type of the album: one of "album" , "single" , or "compilation".
   public var albumType: String?
   ///The artists of the album. Each artist object includes a link in href to more detailed information about the artist.
   public var artists: [SPArtist]?
   ///The markets in which the album is available: [ISO 3166-1 alpha-2 country codes](http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2){:target="_blank"}. Note that an album is considered available in a market when at least 1 of its tracks is available in that market.
   public var availableMarkets: [String]?
   ///The copyright statements of the album.
   public var copyrights: [SPCopyright]?
   ///Known external IDs for the album.
   public var externalIds: SPExternalID?
   ///Known external URLs for this album.
   public var externalUrls: SPExternalURL?
   ///A list of the genres used to classify the album. For example: "Prog Rock" , "Post-Grunge". (If not yet classified, the array is empty.)
   public var genres: [String]?
   ///A link to the Web API endpoint providing full details of the album.
   public var href: String?
   ///The [Spotify ID](/documentation/web-api/#spotify-uris-and-ids) for the album.
   public var id: String
   ///The cover art for the album in various sizes, widest first.
   public var images: [SPImage]?
   ///The label for the album.
   public var label: String?
   ///The name of the album. In case of an album takedown, the value may be an empty string.
   public var name: String
   ///The popularity of the album. The value will be between 0 and 100, with 100 being the most popular. The popularity is calculated from the popularity of the album's individual tracks.
   public var popularity: Int?
   ///The date the album was first released, for example 1981. Depending on the precision, it might be shown as 1981-12 or 1981-12-15.
   public var releaseDate: String?
   ///The precision with which release_date value is known: year , month , or day.
   public var releaseDatePrecision: String?
   ///Part of the response when [Track Relinking](/documentation/general/guides/track-relinking-guide/) is applied, the original track is not available in the given market, and Spotify did not have any tracks to relink it with. The track response will still contain metadata for the original track, and a restrictions object containing the reason why the track is not available: "restrictions" : {"reason" : "market"}
   public var restrictions: SPRestrictions?
   ///The tracks of the album.
   public var tracks: [SPTrack]?
   ///The object type: "album"
   public var type: String?
   ///The [Spotify URI](/documentation/web-api/#spotify-uris-and-ids) for the album.
   public var uri: String

    public init(albumType: String? = nil, artists: [SPArtist]? = nil, availableMarkets: [String]? = nil, copyrights: [SPCopyright]? = nil, externalIds: SPExternalID? = nil, externalUrls: SPExternalURL? = nil, genres: [String]? = nil, href: String? = nil, id: String, images: [SPImage]? = nil, label: String? = nil, name: String, popularity: Int? = nil, releaseDate: String? = nil, releaseDatePrecision: String? = nil, restrictions: SPRestrictions? = nil, tracks: [SPTrack]? = nil, type: String? = nil, uri: String) {
        self.albumType = albumType
        self.artists = artists
        self.availableMarkets = availableMarkets
        self.copyrights = copyrights
        self.externalIds = externalIds
        self.externalUrls = externalUrls
        self.genres = genres
        self.href = href
        self.id = id
        self.images = images
        self.label = label
        self.name = name
        self.popularity = popularity
        self.releaseDate = releaseDate
        self.releaseDatePrecision = releaseDatePrecision
        self.restrictions = restrictions
        self.tracks = tracks
        self.type = type
        self.uri = uri
    }
}
