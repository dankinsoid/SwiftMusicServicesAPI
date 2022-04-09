//
// Created by Данил Войдилов on 08.04.2022.
//

import Foundation
import SwiftHttp

extension VK.API {

	public func playlistPageRequest<Output: HTMLStringInitable>(id: String, section: VKAudioPageInput.Section? = nil, block: VKAudioPageInput.Block? = nil, z: String? = nil) async throws -> Output {
		let input =  VKAudioPageInput(section: section, block: block, z: z)
		return try await request(
				url: baseURL.path("audios\(id)").query(from: input),
				method: .get
		)
	}

	public func playlists(id oid: Int) async throws -> [VKPlaylistItemHTML] {
		try await (playlistPageRequest(id: "\(oid)", section: .my, block: .my_playlists) as VKAudioPlaylistPage).playlists
	}
}