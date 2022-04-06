public struct SPImage: Codable {
   ///The image height in pixels. If unknown: null or not returned.
   public var height: Int?
   ///The source URL of the image.
   public var url: String
   ///The image width in pixels. If unknown: null or not returned.
   public var width: Int?
}
