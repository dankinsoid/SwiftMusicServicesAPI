import Foundation

public struct SPSavedShow: Codable {
   ///The date and time the show was saved.
   public var addedAt: Date
   ///Information about the show.
   public var show: SPShow
}
