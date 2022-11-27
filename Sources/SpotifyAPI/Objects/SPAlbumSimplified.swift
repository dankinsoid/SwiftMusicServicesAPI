public struct SPAlbumSimplified: Codable {
   ///The field is present when getting an artist's albums. Possible values are "album", "single", "compilation", "appears_on". Compare to album_type this field represents relationship between the artist and the album.
   public var albumGroup: String?
   ///The type of the album: one of "album", "single", or "compilation".
   public var albumType: String
   ///The artists of the album. Each artist object includes a link in href to more detailed information about the artist.
   public var artists: [SPArtist]?
   ///The markets in which the album is available: [ISO 3166-1 alpha-2 country codes](http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2){:target="_blank"}. Note that an album is considered available in a market when at least 1 of its tracks is available in that market.
   public var availableMarkets: [String]
   ///Known external URLs for this album.
   public var externalUrls: SPExternalURL?
   ///A link to the Web API endpoint providing full details of the album.
   public var href: String
   ///The [Spotify ID](/documentation/web-api/#spotify-uris-and-ids) for the album.
   public var id: String
   ///The cover art for the album in various sizes, widest first.
   public var images: [SPImage]?
   ///The name of the album. In case of an album takedown, the value may be an empty string.
   public var name: String
   ///The date the album was first released, for example 1981. Depending on the precision, it might be shown as 1981-12 or 1981-12-15.
   public var releaseDate: String
   ///The precision with which release_date value is known: year , month , or day.
   public var releaseDatePrecision: String
   ///Part of the response when [Track Relinking](/documentation/general/guides/track-relinking-guide/) is applied, the original track is not available in the given market, and Spotify did not have any tracks to relink it with. The track response will still contain metadata for the original track, and a restrictions object containing the reason why the track is not available: "restrictions" : {"reason" : "market"}
   public var restrictions: SPRestrictions?
   ///The object type: "album"
   public var type: String
   ///The [Spotify URI](/documentation/web-api/#spotify-uris-and-ids) for the album.
   public var uri: String
    
    public init(albumGroup: String? = nil, albumType: String, artists: [SPArtist]? = nil, availableMarkets: [String], externalUrls: SPExternalURL? = nil, href: String, id: String, images: [SPImage]? = nil, name: String, releaseDate: String, releaseDatePrecision: String, restrictions: SPRestrictions? = nil, type: String, uri: String) {
        self.albumGroup = albumGroup
        self.albumType = albumType
        self.artists = artists
        self.availableMarkets = availableMarkets
        self.externalUrls = externalUrls
        self.href = href
        self.id = id
        self.images = images
        self.name = name
        self.releaseDate = releaseDate
        self.releaseDatePrecision = releaseDatePrecision
        self.restrictions = restrictions
        self.type = type
        self.uri = uri
    }
}
