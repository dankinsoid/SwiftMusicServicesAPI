//
// Created by Данил Войдилов on 08.04.2022.
//

import Foundation
import SwiftSoup
import SwiftHttp
import SimpleCoders

extension VK.API {

	public func myTracksPageRequest(start_from: String, block: String) async throws -> VKAudioListSection {
		let input = MyTracksPageRequestInput(act: .block, block: block, start_from: start_from)
		try! print(baseURL.path("audio").query(from: input).url.absoluteString)
		let response = try await rawRequest(
				executor: client.dataTask,
				url: baseURL.path("audio").query(from: input),
				method: .post,
				headers: headers(
					with: [
						.xRequestedWith: "XMLHttpRequest"
//						"Referer": baseURL.path("audio").query(from: input).query(["back_url": "/audio", "back_hash": "cd3bcbbfc8e65ca3"]).url.absoluteString
					]
				),
				body: Data("_ajax=1".utf8)
		)
		var string = String(data: response.data, encoding: .utf8) ?? ""
		print(string)
		string = string
				.components(separatedBy: "\"playlist\"")
				.dropFirst()
				.joined(separator: "\"playlist\"")
		string = "{\"data\":[{\"playlist\"\(string)"
		let data = Data(string.utf8)
		return try JSONDecoder().decode(MyTracksPageRequestInputOutput.self, from: data).playlist
	}

	public struct MyTracksPageRequestInput: Codable {
		public var act: VKAct
		public var block: String
		public var start_from: String
	}

	public struct MyTracksPageRequestInputBody: Codable {
		public var _ajax = 1
	}

	public struct MyTracksPageRequestInputOutput: Decodable {
		public var playlist: VKAudioListSection

		public init(from decoder: Decoder) throws {
			let container = try decoder.container(keyedBy: PlainCodingKey.self)
			var unkeyed = try container.nestedUnkeyedContainer(forKey: "data")
			let keyed = try unkeyed.nestedContainer(keyedBy: PlainCodingKey.self)
			do {
				playlist = try keyed.decode(VKAudioListSection.self, forKey: "playlist")
			} catch {
				guard let playlists = try keyed.decode([VKAudioListSection].self, forKey: "playlists").first else {
					throw HttpError.invalidResponse
				}
				self.playlist = playlists
			}
		}
	}
}
