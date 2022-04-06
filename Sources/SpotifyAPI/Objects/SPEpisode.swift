public struct SPEpisode: Codable {
   ///A URL to a 30 second preview (MP3 format) of the episode. null if not available.
   public var audioPreviewUrl: String?
   ///A description of the episode.
   public var description: String
   ///The episode length in milliseconds.
   public var durationMs: Int
   ///Whether or not the episode has explicit content (true = yes it does; false = no it does not OR unknown).
   public var explicit: Bool
   ///External URLs for this episode.
   public var externalUrls: SPExternalURL?
   ///A link to the Web API endpoint providing full details of the episode.
   public var href: String
   ///The [Spotify ID](/documentation/web-api/#spotify-uris-and-ids) for the episode.
   public var id: String
   ///The cover art for the episode in various sizes, widest first.
   public var images: [SPImage]?
   ///True if the episode is hosted outside of Spotify's CDN.
   public var isExternallyHosted: Bool
   ///True if the episode is playable in the given market. Otherwise false.
   public var isPlayable: Bool?
   ///**Note: This field is deprecated and might be removed in the future. Please use the languages field instead.** The language used in the episode, identified by a [ISO 639](https://en.wikipedia.org/wiki/ISO_639) code.
   public var language: String
   ///A list of the languages used in the episode, identified by their [ISO 639](https://en.wikipedia.org/wiki/ISO_639) code.
   public var languages: [String]?
   ///The name of the episode.
   public var name: String
   ///The date the episode was first released, for example "1981-12-15". Depending on the precision, it might be shown as "1981" or "1981-12".
   public var releaseDate: String
   ///The precision with which release_date value is known: "year", "month", or "day".
   public var releaseDatePrecision: String
   ///The user's most recent position in the episode. Set if the supplied access token is a user token and has the scope user-read-playback-position.
   public var resumePoint: SPResumePoint
   ///The show on which the episode belongs.
   public var show: SPShow
   ///The object type: "episode".
   public var type: String
   ///The [Spotify URI](/documentation/web-api/#spotify-uris-and-ids) for the episode.
   public var uri: String
}
