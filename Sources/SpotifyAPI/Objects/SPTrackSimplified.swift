import SwiftAPIClient
import SwiftMusicServicesApi

public struct SPTrackSimplified: Codable {
	/// The artists who performed the track. Each artist object includes a link in href to more detailed information about the artist.
	public var artists: [SPArtist]?
	/// A list of the countries in which the track can be played, identified by their [ISO 3166-1 alpha-2](http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) code.
	public var availableMarkets: Set<CountryCode>?
	/// The disc number (usually 1 unless the album consists of more than one disc).
	public var discNumber: Int?
	/// The track length in milliseconds.
	public var durationMs: Int
	/// Whether or not the track has explicit lyrics ( true = yes it does; false = no it does not OR unknown).
	public var explicit: Bool?
	/// External URLs for this track.
	public var externalUrls: SPExternalURL?
	/// A link to the Web API endpoint providing full details of the track.
	public var href: String
	/// The [Spotify ID](/documentation/web-api/#spotify-uris-and-ids) for the track.
	public var id: String
	/// Part of the response when [Track Relinking](/documentation/general/guides/track-relinking-guide/) is applied. If true , the track is playable in the given market. Otherwise false.
	public var isPlayable: Bool?
	/// Part of the response when [Track Relinking](/documentation/general/guides/track-relinking-guide/) is applied and is only part of the response if the track linking, in fact, exists. The requested track has been replaced with a different track. The track in the linked_from object contains information about the originally requested track.
	public var linkedFrom: SPTrackLink?
	/// Part of the response when [Track Relinking](/documentation/general/guides/track-relinking-guide/) is applied, the original track is not available in the given market, and Spotify did not have any tracks to relink it with. The track response will still contain metadata for the original track, and a restrictions object containing the reason why the track is not available: "restrictions" : {"reason" : "market"}
	public var restrictions: SPRestrictions?
	/// The name of the track.
	public var name: String
	/// A URL to a 30 second preview (MP3 format) of the track.
	public var previewUrl: String
	/// The number of the track. If an album has several discs, the track number is the number on the specified disc.
	public var trackNumber: Int
	/// The object type: "track".
	public var type: String
	/// The [Spotify URI](/documentation/web-api/#spotify-uris-and-ids) for the track.
	public var uri: String
	/// Whether or not the track is from a local file.
	public var isLocal: Bool?

	public init(artists: [SPArtist]? = nil, availableMarkets: Set<CountryCode>? = nil, discNumber: Int? = nil, durationMs: Int, explicit: Bool? = nil, externalUrls: SPExternalURL? = nil, href: String, id: String, isPlayable: Bool? = nil, linkedFrom: SPTrackLink? = nil, restrictions: SPRestrictions? = nil, name: String, previewUrl: String, trackNumber: Int, type: String, uri: String, isLocal: Bool? = nil) {
		self.artists = artists
		self.availableMarkets = availableMarkets
		self.discNumber = discNumber
		self.durationMs = durationMs
		self.explicit = explicit
		self.externalUrls = externalUrls
		self.href = href
		self.id = id
		self.isPlayable = isPlayable
		self.linkedFrom = linkedFrom
		self.restrictions = restrictions
		self.name = name
		self.previewUrl = previewUrl
		self.trackNumber = trackNumber
		self.type = type
		self.uri = uri
		self.isLocal = isLocal
	}
}

extension SPTrackSimplified: Mockable {
	public static let mock = SPTrackSimplified(
		artists: [SPArtist.mock],
		availableMarkets: [.US, .CA, .GB],
		discNumber: 1,
		durationMs: 240_000,
		explicit: false,
		externalUrls: ["spotify": "https://open.spotify.com/track/mock_id_123"],
		href: "https://api.spotify.com/v1/tracks/mock_id_123",
		id: "mock_id_123",
		isPlayable: true,
		linkedFrom: nil,
		restrictions: nil,
		name: "Mock Track",
		previewUrl: "https://example.com/preview.mp3",
		trackNumber: 1,
		type: "track",
		uri: "spotify:track:mock_id_123",
		isLocal: false
	)
}
