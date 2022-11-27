public struct SPUser: Codable {
   ///The name displayed on the user's profile. null if not available.
   public var displayName: String?
   ///Known public external URLs for this user.
   public var externalUrls: SPExternalURL?
   ///Information about the followers of this user.
   public var followers: [SPFollower]?
   ///A link to the Web API endpoint for this user.
   public var href: String
   ///The [Spotify user ID](/documentation/web-api/#spotify-uris-and-ids) for this user.
   public var id: String
   ///The user's profile image.
   public var images: [SPImage]?
   ///The object type: "user"
   public var type: String
   ///The [Spotify URI](/documentation/web-api/#spotify-uris-and-ids) for this user.
   public var uri: String
    
    public init(displayName: String? = nil, externalUrls: SPExternalURL? = nil, followers: [SPFollower]? = nil, href: String, id: String, images: [SPImage]? = nil, type: String, uri: String) {
        self.displayName = displayName
        self.externalUrls = externalUrls
        self.followers = followers
        self.href = href
        self.id = id
        self.images = images
        self.type = type
        self.uri = uri
    }
}
