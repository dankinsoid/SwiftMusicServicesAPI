import SwiftAPIClient

public struct SPRecommendations: Codable {
	/// An array of [recommendation seed objects](#recommendations-seed-object).
	public var seeds: [SPRecommendationsSeed]?
	/// An array of [track object (simplified)](#track-object-simplified) ordered according to the parameters supplied.
	public var tracks: [SPTrackSimplified]?

	public init(seeds: [SPRecommendationsSeed]? = nil, tracks: [SPTrackSimplified]? = nil) {
		self.seeds = seeds
		self.tracks = tracks
	}
}

extension SPRecommendations: Mockable {
	public static let mock = SPRecommendations(
		seeds: [SPRecommendationsSeed.mock],
		tracks: [SPTrackSimplified.mock]
	)
}
