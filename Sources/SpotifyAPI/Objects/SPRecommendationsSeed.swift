public struct SPRecommendationsSeed: Codable {
   ///The number of tracks available after min_* and max_* filters have been applied.
   public var afterFilteringSize: Int
   ///The number of tracks available after relinking for regional availability.
   public var afterRelinkingSize: Int
   ///A link to the full track or artist data for this seed. For tracks this will be a link to a [Track Object](#track-object-full). For artists a link to [an Artist Object](#artist-object-full). For genre seeds, this value will be null.
   public var href: String?
   ///The id used to select this seed. This will be the same as the string used in the seed_artists , seed_tracks or seed_genres parameter.
   public var id: String
   ///The number of recommended tracks available for this seed.
   public var initialPoolSize: Int
   ///The entity type of this seed. One of artist , track or genre.
   public var type: String
    
    public init(afterFilteringSize: Int, afterRelinkingSize: Int, href: String? = nil, id: String, initialPoolSize: Int, type: String) {
        self.afterFilteringSize = afterFilteringSize
        self.afterRelinkingSize = afterRelinkingSize
        self.href = href
        self.id = id
        self.initialPoolSize = initialPoolSize
        self.type = type
    }
}
