import Foundation
import SwiftHttp

public extension VK.API {

	func playlistPageRequest<Output: HTMLStringInitable>(id: String, section: VKAudioPageInput.Section? = nil, block: VKAudioPageInput.Block? = nil, z: String? = nil) async throws -> Output {
        try await client("audios\(id)")
            .query(VKAudioPageInput(section: section, block: block, z: z))
            .call(.http, as: .htmlInitable)
	}

	func playlists(id oid: Int) async throws -> [VKPlaylistItemHTML] {
		try await (playlistPageRequest(id: "\(oid)", section: .my, block: .my_playlists) as VKAudioPlaylistPage).playlists
	}
}
