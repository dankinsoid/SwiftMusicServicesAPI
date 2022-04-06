import Foundation

public struct SPSavedAlbum: Codable {
   ///The date and time the album was saved.
   public var addedAt: Date
   ///Information about the album.
   public var album: SPAlbum
}
