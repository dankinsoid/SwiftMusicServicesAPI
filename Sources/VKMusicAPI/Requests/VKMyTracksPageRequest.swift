import Foundation
import SimpleCoders
import SwiftHttp
import SwiftSoup

public extension VK.API {

	func myTracksPageRequest(start_from: String, block: String) async throws -> VKAudioListSection {
		let input = MyTracksPageRequestInput(act: .block, block: block, start_from: start_from)
		let response = try await rawRequest(
			url: baseURL.path("audio").query(from: input),
			method: .post,
			headers: headers(multipart: true),
			body: multipartData(MyTracksPageRequestInputBody())
		)
		var string = String(data: response.data, encoding: .utf8) ?? ""
		string = string
			.components(separatedBy: "\"playlist\"")
			.dropFirst()
			.joined(separator: "\"playlist\"")
		string = "{\"data\":[{\"playlist\"\(string)"
		let data = Data(string.utf8)
		return try JSONDecoder().decode(MyTracksPageRequestInputOutput.self, from: data).playlist
	}

	struct MyTracksPageRequestInput: Codable {
		public var act: VKAct
		public var block: String
		public var start_from: String
	}

	struct MyTracksPageRequestInputBody: Codable {
		public var _ajax = 1
	}

	struct MyTracksPageRequestInputOutput {
		public var playlist: VKAudioListSection
	}
}

extension VK.API.MyTracksPageRequestInputOutput: Decodable {
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
			playlist = playlists
		}
	}
}
