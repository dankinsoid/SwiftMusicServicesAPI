public struct SPPlaylistSimplified: Codable {
	/// Returns true if context is not search and the owner allows other users to modify the playlist. Otherwise returns false.
	public var collaborative: Bool?
	/// The playlist description. _Only returned for modified, verified playlists, otherwise_ null .
	public var description: String?
	/// Known external URLs for this playlist.
	public var externalUrls: SPExternalURL?
	/// A link to the Web API endpoint providing full details of the playlist.
	public var href: String
	/// The [Spotify ID](/documentation/web-api/#spotify-uris-and-ids) for the playlist.
	public var id: String
	/// Images for the playlist. The array may be empty or contain up to three images. The images are returned by size in descending order. See [Working with Playlists](/documentation/general/guides/working-with-playlists/)._Note: If returned, the source URL for the image ( url ) is temporary and will expire in less than a day._
	public var images: [SPImage]?
	/// The name of the playlist.
	public var name: String
	/// The user who owns the playlist
	public var owner: SPUser
	/// The playlist's public/private status: true the playlist is public, false the playlist is private, null the playlist status is not relevant. For more about public/private status, see [Working with Playlists](/documentation/general/guides/working-with-playlists/).
	public var `public`: Bool?
	/// The version identifier for the current playlist. Can be supplied in other requests to target a specific playlist version
	public var snapshotId: String?
	/// Information about the tracks of the playlist.
	public var tracks: SPTracks?
	/// The object type: "playlist"
	public var type: String?
	/// The [Spotify URI](/documentation/web-api/#spotify-uris-and-ids) for the playlist.
	public var uri: String

	public init(collaborative: Bool? = nil, description: String? = nil, externalUrls: SPExternalURL? = nil, href: String, id: String, images: [SPImage]? = nil, name: String, owner: SPUser, snapshotId: String? = nil, tracks: SPTracks? = nil, type: String? = nil, uri: String) {
		self.collaborative = collaborative
		self.description = description
		self.externalUrls = externalUrls
		self.href = href
		self.id = id
		self.images = images
		self.name = name
		self.owner = owner
		self.snapshotId = snapshotId
		self.tracks = tracks
		self.type = type
		self.uri = uri
	}
}
