import Foundation

public struct SPPlaylistTrack: Codable {
   ///The date and time the track or episode was added._Note that some very old playlists may return null in this field._
   public var addedAt: Date?
   ///The Spotify user who added the track or episode._Note that some very old playlists may return null in this field._
   public var addedBy: SPUser?
   ///Whether this track or episode is a [local file](https://developer.spotify.com/web-api/local-files-spotify-playlists/) or not.
   public var isLocal: Bool?
   ///Information about the track or episode.
   public var track: SPTrack?
}
