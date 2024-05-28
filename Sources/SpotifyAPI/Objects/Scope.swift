import Foundation

/// User scopes, specifying exactly what types of data the application wants to access.
public enum Scope: String, CaseIterable, Codable {

    // MARK: - Images
    case ugcImageUpload = "ugc-image-upload"

    // MARK: - Spotify Connect
    case userReadPlaybackState = "user-read-playback-state"
    case userModifyPlaybackState = "user-modify-playback-state"
    case userReadCurrentlyPlaying = "user-read-currently-playing"

    // MARK: - Playback
    case appRemoteControl = "app-remote-control"
    /// Control playback of a Spotify track. This scope is currently only available to
    /// Spotify native SDKs (for example, the iOS SDK and the Android SDK). The user must
    /// have a Spotify Premium account.
    case streaming

    // MARK: - Playlists
    /// Read access to user's private playlists.
    case playlistReadPrivate = "playlist-read-private"
    /// Include collaborative playlists when requesting a user's playlists.
    case playlistReadCollaborative = "playlist-read-collaborative"
    /// Write access to a user's private playlists.
    case playlistModifyPrivate = "playlist-modify-private"
    /// Write access to a user's public playlists.
    case playlistModifyPublic = "playlist-modify-public"

    // MARK: - Follow
    /// Write/delete access to the list of artists and other users that the user follows.
    case userFollowModify = "user-follow-modify"
    /// Read access to the list of artists and other users that the user follows.
    case userFollowRead = "user-follow-read"

    // MARK: - Listening History
    /// Read access to read the player's playback state
    case userReadPlaybackPosition = "user-read-playback-position"
    /// Read access to a user's top artists and tracks.
    case userTopRead = "user-top-read"
    /// Read access to user's currently playing track
    case userReadRecentlyPlayed = "user-read-recently-played"

    // MARK: - Library
    case userLibraryModify = "user-library-modify"
    case userLibraryRead = "user-library-read"

    // MARK: - Users
    /// Read access to user’s email address.
    case userReadEmail = "user-read-email"
    /// Read access to user’s subscription details (type of user account).
    case userReadPrivate = "user-read-private"

    // MARK: - Open Access
    case userSoaLink = "user-soa-link"
    case userSoaUnlink = "user-soa-unlink"
    case soaManageEntitlements = "soa-manage-entitlements"
    case soaManagePartner = "soa-manage-partner"
    case soaCreatePartner = "soa-create-partner"
}
