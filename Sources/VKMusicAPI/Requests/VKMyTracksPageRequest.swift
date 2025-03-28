import Foundation
import SwiftAPIClient
import SwiftSoup
import SimpleCoders

public extension VK.API {

	func myTracksPageRequest(start_from: String?, block: String) async throws -> VKAudioListSection {
		var string = try await client("audio")
			.xmlHttpRequest
			.query(MyTracksPageRequestInput(act: .block, block: block, start_from: start_from))
			.bodyEncoder(.formURL)
			.body(MyTracksPageRequestInputBody())
			.post
			.call(.http, as: .string)
		string = string
			.components(separatedBy: "\"playlist\"")
			.dropFirst()
			.joined(separator: "\"playlist\"")
		string = "{\"data\":[{\"playlist\"\(string)"
		let data = Data(string.utf8)
		return try JSONDecoder().decode(MyTracksPageRequestInputOutput.self, from: data).playlist
	}

	func myTracksPageRequest(id: Int, start_from: String) async throws -> VKAudioListSection {
		var string = try await client("audios\(id)")
			.xmlHttpRequest
			.query(MyTracksPageRequestInput(section: .my, start_from: start_from))
			.bodyEncoder(.formURL)
			.body(MyTracksPageRequestInputBody())
			.post
			.call(.http, as: .string)
		string = string
			.components(separatedBy: "\"playlist\"")
			.dropFirst()
			.joined(separator: "\"playlist\"")
		string = "{\"data\":[{\"playlist\"\(string)"
		let data = Data(string.utf8)
		return try JSONDecoder().decode(MyTracksPageRequestInputOutput.self, from: data).playlist
	}

	struct MyTracksPageRequestInput: Codable {
		public var act: VKAct?
		public var start_from: String?
		public var section: VKAudioPageInput.Section?
		public var block: String?

		public init(act: VKAct? = nil, block: String? = nil, section: VKAudioPageInput.Section? = nil, start_from: String?) {
			self.act = act
			self.block = block
			self.section = section
			self.start_from = start_from
		}
	}

	struct MyTracksPageRequestInputBody: Codable {
		public var _ajax = 1

		public init(_ajax: Int = 1) {
			self._ajax = _ajax
		}
	}

	struct MyTracksPageRequestInputOutput {
		public var playlist: VKAudioListSection

		public init(playlist: VKAudioListSection) {
			self.playlist = playlist
		}
	}
}

extension VK.API.MyTracksPageRequestInputOutput: Decodable {
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: SimpleCoders.PlainCodingKey.self)
		var unkeyed = try container.nestedUnkeyedContainer(forKey: "data")
		let keyed = try unkeyed.nestedContainer(keyedBy: SimpleCoders.PlainCodingKey.self)
		do {
			playlist = try keyed.decode(VKAudioListSection.self, forKey: "playlist")
		} catch {
			guard let playlists = try keyed.decode([VKAudioListSection].self, forKey: "playlists").first else {
				throw DecodingError.dataCorrupted(
					DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Empty playlists")
				)
			}
			playlist = playlists
		}
	}
}
