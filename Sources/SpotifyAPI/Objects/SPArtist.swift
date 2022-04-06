public struct SPArtist: Codable {
   ///Known external URLs for this artist.
   public var externalUrls: SPExternalURL?
   ///Information about the followers of the artist.
   public var followers: [SPFollower]?
   ///A list of the genres the artist is associated with. For example: "Prog Rock" , "Post-Grunge". (If not yet classified, the array is empty.)
   public var genres: [String]?
   ///A link to the Web API endpoint providing full details of the artist.
   public var href: String?
   ///The [Spotify ID](/documentation/web-api/#spotify-uris-and-ids) for the artist.
   public var id: String
   ///Images of the artist in various sizes, widest first.
   public var images: [SPImage]?
   ///The name of the artist.
   public var name: String
   ///The popularity of the artist. The value will be between 0 and 100, with 100 being the most popular. The artist's popularity is calculated from the popularity of all the artist's tracks.
   public var popularity: Int?
   ///The object type: "artist"
   public var type: String?
   ///The [Spotify URI](/documentation/web-api/#spotify-uris-and-ids) for the artist.
   public var uri: String
}
