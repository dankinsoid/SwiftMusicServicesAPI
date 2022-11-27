public struct SPCategory: Codable {
   ///A link to the Web API endpoint returning full details of the category.
   public var href: String
   ///The category icon, in various sizes.
   public var icons: [SPImage]?
   ///The [Spotify category ID](/documentation/web-api/#spotify-uris-and-ids) of the category.
   public var id: String
   ///The name of the category.
   public var name: String
    
    public init(href: String, icons: [SPImage]? = nil, id: String, name: String) {
        self.href = href
        self.icons = icons
        self.id = id
        self.name = name
    }
}
