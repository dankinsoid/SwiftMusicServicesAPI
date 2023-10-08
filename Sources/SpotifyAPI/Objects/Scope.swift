import Foundation

/// User scopes, specifying exactly what types of data the application wants to access.
public enum Scope: String, CaseIterable {
	/// Read access to user's private playlists.
	case playlistReadPrivate = "playlist-read-private"
	/// Include collaborative playlists when requesting a user's playlists.
	case playlistReadCollaborative = "playlist-read-collaborative"
	/// Write access to a user's public playlists.
	case playlistModifyPublic = "playlist-modify-public"
	/// Write access to a user's private playlists.
	case playlistModifyPrivate = "playlist-modify-private"
	/// Control playback of a Spotify track. This scope is currently only available to
	// Spotify native SDKs (for example, the iOS SDK and the Android SDK). The user must
	// have a Spotify Premium account.
	case streaming
	/// Write/delete access to the list of artists and other users that the user follows.
	case userFollowModify = "user-follow-modify"
	/// Read access to the list of artists and other users that the user follows.
	case userFollowRead = "user-follow-read"
	/// Write/delete access to a user's "Your Music" library.
	case userLibraryModify = "user-library-modify"
	/// Read access to a user's "Your Music" library.
	case userLibraryRead = "user-library-read"
	/// Read access to user’s subscription details (type of user account).
	case userReadPrivate = "user-read-private"
	/// Read access to the user's birthdate.
	case userReadBirthDate = "user-read-birthdate"
	/// Read access to user’s email address.
	case userReadEmail = "user-read-email"
	/// Read access to a user's top artists and tracks.
	case userReadTop = "user-top-read"
	/// Read access to read the player's playback state
	case userReadPlaybackState = "user-read-playback-state"
	/// Control the player's playback state
	case userModifyPlaybackState = "user-modify-playback-state"
	/// Read access to user's currently playing track
	case userReadCurrentlyPlaying = "user-read-currently-playing"
}
