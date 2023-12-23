import Foundation
import SwiftHttp

public extension VK.API {

	func playlistPageRequest<Output: HTMLStringInitable>(id: String, section: VKAudioPageInput.Section? = nil, block: VKAudioPageInput.Block? = nil, z: String? = nil) async throws -> Output {
		let input = VKAudioPageInput(section: section, block: block, z: z)
		return try await htmlRequest(
			url: baseURL.path("audios\(id)").query(from: input),
			method: .get
		)
	}

	func playlists(id oid: Int) async throws -> [VKPlaylistItemHTML] {
		try await (playlistPageRequest(id: "\(oid)", section: .my, block: .my_playlists) as VKAudioPlaylistPage).playlists
	}
}
