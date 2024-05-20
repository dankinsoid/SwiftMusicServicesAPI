import Foundation
import SwiftHttp

public extension VK.API {

	func playlistPageRequest<Output: HTMLStringInitable>(id: String, section: VKAudioPageInput.Section? = nil, block: VKAudioPageInput.Block? = nil, z: String? = nil) async throws -> Output {
		let input = VKAudioPageInput(section: section, block: block, z: z)
		return try await request(
			url: baseURL.path("audios\(id)").query(from: input),
			method: .get
		)
	}

	@available(*, deprecated, renamed: "myPlaylists")
	func playlists(id oid: Int) async throws -> [VKPlaylistItemHTML] {
		try await (playlistPageRequest(id: "\(oid)", section: .my, block: .my_playlists) as VKAudioPlaylistPage).playlists
	}

	func myPlaylists(id oid: String) async throws -> [VKPlaylistItemHTML] {
		try await (playlistPageRequest(id: oid, section: .my, block: .my_playlists) as VKAudioPlaylistPage).playlists
	}

	func playlists(id oid: String) async throws -> [VKPlaylistItemHTML] {
		try await (playlistPageRequest(id: oid, section: nil, block: nil) as VKAudioPlaylistPage).playlists
	}
}
