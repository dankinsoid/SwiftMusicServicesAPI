public struct SPTrack: Codable {
	/// The album on which the track appears. The album object includes a link in href to full information about the album.
	public var album: SPAlbum?
	/// The artists who performed the track. Each artist object includes a link in href to more detailed information about the artist.
	public var artists: [SPArtist]?
	/// A list of the countries in which the track can be played, identified by their [ISO 3166-1 alpha-2](http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) code.
	public var availableMarkets: [String]?
	/// The disc number (usually 1 unless the album consists of more than one disc).
	public var discNumber: Int?
	/// The track length in milliseconds.
	public var durationMs: Int
	/// Whether or not the track has explicit lyrics ( true = yes it does; false = no it does not OR unknown).
	public var explicit: Bool?
	/// Known external IDs for the track.
	public var externalIds: SPExternalID?
	/// Known external URLs for this track.
	public var externalUrls: SPExternalURL?
	/// A link to the Web API endpoint providing full details of the track.
	public var href: String?
	/// The [Spotify ID](/documentation/web-api/#spotify-uris-and-ids) for the track.
	public var id: String
	/// Part of the response when [Track Relinking](/documentation/general/guides/track-relinking-guide/) is applied. If true , the track is playable in the given market. Otherwise false.
	public var isPlayable: Bool?
	/// Part of the response when [Track Relinking](/documentation/general/guides/track-relinking-guide/) is applied, and the requested track has been replaced with different track. The track in the linked_from object contains information about the originally requested track.
	public var linkedFrom: SPTrackLink?
	/// Part of the response when [Track Relinking](/documentation/general/guides/track-relinking-guide/) is applied, the original track is not available in the given market, and Spotify did not have any tracks to relink it with. The track response will still contain metadata for the original track, and a restrictions object containing the reason why the track is not available: "restrictions" : {"reason" : "market"}
	public var restrictions: SPRestrictions?
	/// The name of the track.
	public var name: String
	/// The popularity of the track. The value will be between 0 and 100, with 100 being the most popular.The popularity of a track is a value between 0 and 100, with 100 being the most popular. The popularity is calculated by algorithm and is based, in the most part, on the total number of plays the track has had and how recent those plays are.Generally speaking, songs that are being played a lot now will have a higher popularity than songs that were played a lot in the past. Duplicate tracks (e.g. the same track from a single and an album) are rated independently. Artist and album popularity is derived mathematically from track popularity. Note that the popularity value may lag actual popularity by a few days: the value is not updated in real time.
	public var popularity: Int?
	/// A link to a 30 second preview (MP3 format) of the track. Can be null
	public var previewUrl: String?
	/// The number of the track. If an album has several discs, the track number is the number on the specified disc.
	public var trackNumber: Int?
	/// The object type: "track".
	public var type: String?
	/// The [Spotify URI](/documentation/web-api/#spotify-uris-and-ids) for the track.
	public var uri: String
	/// Whether or not the track is from a local file.
	public var isLocal: Bool?

	public init(album: SPAlbum? = nil, artists: [SPArtist]? = nil, availableMarkets: [String]? = nil, discNumber: Int? = nil, durationMs: Int, explicit: Bool? = nil, externalIds: SPExternalID? = nil, externalUrls: SPExternalURL? = nil, href: String? = nil, id: String, isPlayable: Bool? = nil, linkedFrom: SPTrackLink? = nil, restrictions: SPRestrictions? = nil, name: String, popularity: Int? = nil, previewUrl: String? = nil, trackNumber: Int? = nil, type: String? = nil, uri: String, isLocal: Bool? = nil) {
		self.album = album
		self.artists = artists
		self.availableMarkets = availableMarkets
		self.discNumber = discNumber
		self.durationMs = durationMs
		self.explicit = explicit
		self.externalIds = externalIds
		self.externalUrls = externalUrls
		self.href = href
		self.id = id
		self.isPlayable = isPlayable
		self.linkedFrom = linkedFrom
		self.restrictions = restrictions
		self.name = name
		self.popularity = popularity
		self.previewUrl = previewUrl
		self.trackNumber = trackNumber
		self.type = type
		self.uri = uri
		self.isLocal = isLocal
	}
}
