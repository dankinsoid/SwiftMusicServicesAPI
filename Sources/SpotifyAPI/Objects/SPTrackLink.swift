import SwiftAPIClient

public struct SPTrackLink: Codable, Sendable, Equatable {
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

extension SPTrackLink: Mockable {
	public static let mock = SPTrackLink(
		externalUrls: ["spotify": "https://open.spotify.com/track/mock_id_123"],
		href: "https://api.spotify.com/v1/tracks/mock_id_123",
		id: "mock_id_123",
		type: "track",
		uri: "spotify:track:mock_id_123"
	)
}
