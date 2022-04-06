public struct SPRecommendations: Codable {
   ///An array of [recommendation seed objects](#recommendations-seed-object).
   public var seeds: [SPRecommendationsSeed]?
   ///An array of [track object (simplified)](#track-object-simplified) ordered according to the parameters supplied.
   public var tracks: [SPTrackSimplified]?
}
