import Foundation

public struct SPPlayHistory: Codable {
   ///The track the user listened to.
   public var track: SPTrackSimplified
   ///The date and time the track was played. ISO8601
   public var playedAt: Date
   ///The context the track was played from.
   public var context: SPContext
}
