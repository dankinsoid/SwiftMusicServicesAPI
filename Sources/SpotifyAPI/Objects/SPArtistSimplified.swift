public struct SPArtistSimplified: Codable {
	/// Known external URLs for this artist.
	public var externalUrls: SPExternalURL?
	/// A link to the Web API endpoint providing full details of the artist.
	public var href: String
	/// The [Spotify ID](/documentation/web-api/#spotify-uris-and-ids) for the artist.
	public var id: String
	/// The name of the artist.
	public var name: String
	/// The object type: "artist"
	public var type: String
	/// The [Spotify URI](/documentation/web-api/#spotify-uris-and-ids) for the artist.
	public var uri: String

	public init(externalUrls: SPExternalURL? = nil, href: String, id: String, name: String, type: String, uri: String) {
		self.externalUrls = externalUrls
		self.href = href
		self.id = id
		self.name = name
		self.type = type
		self.uri = uri
	}
}
