import SwiftAPIClient

public struct SPContext: Codable {
	/// The object type, e.g. "artist", "playlist", "album".
	public var type: String
	/// A link to the Web API endpoint providing full details of the track.
	public var href: String
	/// External URLs for this context.
	public var externalUrls: SPExternalURL?
	/// The [Spotify URI](/documentation/web-api/#spotify-uris-and-ids) for the context.
	public var uri: String

	public init(type: String, href: String, externalUrls: SPExternalURL? = nil, uri: String) {
		self.type = type
		self.href = href
		self.externalUrls = externalUrls
		self.uri = uri
	}
}

extension SPContext: Mockable {
	public static let mock = SPContext(
		type: "playlist",
		href: "https://api.spotify.com/v1/playlists/mock_id_123",
		externalUrls: ["spotify": "https://open.spotify.com/playlist/mock_id_123"],
		uri: "spotify:playlist:mock_id_123"
	)
}
