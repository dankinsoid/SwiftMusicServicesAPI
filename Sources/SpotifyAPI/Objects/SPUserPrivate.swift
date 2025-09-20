import SwiftAPIClient

public struct SPUserPrivate: Codable {
	/// The country of the user, as set in the user's account profile. An [ISO 3166-1 alpha-2 country code](http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2). _This field is only available when the current user has granted access to the [user-read-private](/documentation/general/guides/authorization-guide/#list-of-scopes) scope._
	public var country: CountryCode?
	/// The name displayed on the user's profile. null if not available.
	public var displayName: String?
	/// The user's email address, as entered by the user when creating their account._**Important!** This email address is unverified; there is no proof that it actually belongs to the user.__This field is only available when the current user has granted access to the [user-read-email](/documentation/general/guides/authorization-guide/#list-of-scopes) scope._
	public var email: String?
	/// Known external URLs for this user.
	public var externalUrls: SPExternalURL?
	/// Information about the followers of the user.
	public var followers: SPFollowers?
	/// A link to the Web API endpoint for this user.
	public var href: String?
	/// The [Spotify user ID](/documentation/web-api/#spotify-uris-and-ids) for the user
	public var id: String
	/// The user's profile image.
	public var images: [SPImage]?
	/// The user's Spotify subscription level: "premium", "free", etc. (The subscription level "open" can be considered the same as "free".)_This field is only available when the current user has granted access to the [user-read-private](/documentation/general/guides/authorization-guide/#list-of-scopes) scope._
	public var product: String?
	/// The object type: "user"
	public var type: String?
	/// The [Spotify URI](/documentation/web-api/#spotify-uris-and-ids) for the user.
	public var uri: String?

	public init(country: CountryCode? = nil, displayName: String? = nil, email: String? = nil, externalUrls: SPExternalURL? = nil, followers: SPFollowers? = nil, href: String? = nil, id: String, images: [SPImage]? = nil, product: String? = nil, type: String? = nil, uri: String? = nil) {
		self.country = country
		self.displayName = displayName
		self.email = email
		self.externalUrls = externalUrls
		self.followers = followers
		self.href = href
		self.id = id
		self.images = images
		self.product = product
		self.type = type
		self.uri = uri
	}
}

extension SPUserPrivate: Mockable {
	public static let mock = SPUserPrivate(
		country: .US,
		displayName: "Mock User",
		email: "mock@example.com",
		externalUrls: ["spotify": "https://open.spotify.com/user/mock_id_123"],
		followers: SPFollowers.mock,
		href: "https://api.spotify.com/v1/me",
		id: "mock_id_123",
		images: [SPImage.mock],
		product: "premium",
		type: "user",
		uri: "spotify:user:mock_id_123"
	)
}
