import Foundation

public enum VKAct: String, Codable, CaseIterable {
	case loadSection = "load_section", login, section, loadCatalogSection = "load_catalog_section", add, reloadAudio = "reload_audio", savePlaylist = "save_playlist", playlistsByAudio = "playlists_by_audio", addAudioToPlaylist = "add_audio_to_playlist", morePlaylistsAdd = "more_playlists_add", block, unknown
    
    public init(from decoder: Decoder) throws {
        self = try Self(rawValue: String(from: decoder)) ?? .unknown
    }
}

public struct VKActInput: Encodable {
	public var act: VKAct?
}
