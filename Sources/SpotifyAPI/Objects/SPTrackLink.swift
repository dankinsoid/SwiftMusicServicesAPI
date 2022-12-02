public struct SPTrackLink: Codable {
	/// Known external URLs for this track.
	public var externalUrls: SPExternalURL?
	/// A link to the Web API endpoint providing full details of the track.
	public var href: String
	/// The [Spotify ID](/documentation/web-api/#spotify-uris-and-ids) for the track.
	public var id: String
	/// The object type: "track".
	public var type: String
	/// The [Spotify URI](/documentation/web-api/#spotify-uris-and-ids) for the track.
	public var uri: String

	public init(externalUrls: SPExternalURL? = nil, href: String, id: String, type: String, uri: String) {
		self.externalUrls = externalUrls
		self.href = href
		self.id = id
		self.type = type
		self.uri = uri
	}
}
