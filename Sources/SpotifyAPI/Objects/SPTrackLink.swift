public struct SPTrackLink: Codable {
   ///Known external URLs for this track.
   public var externalUrls: SPExternalURL?
   ///A link to the Web API endpoint providing full details of the track.
   public var href: String
   ///The [Spotify ID](/documentation/web-api/#spotify-uris-and-ids) for the track.
   public var id: String
   ///The object type: "track".
   public var type: String
   ///The [Spotify URI](/documentation/web-api/#spotify-uris-and-ids) for the track.
   public var uri: String
}
