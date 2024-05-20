import Foundation
import SimpleCoders
import SwiftHttp
import SwiftSoup
import VDCodable

public extension VK.API {
	func audioFirstPageRequest(href: String) async throws -> AudioFirstPageRequestOutput {
		try await request(
			url: baseURL
				.path(href.components(separatedBy: "?").first?.trimmingCharacters(in: CharacterSet(charactersIn: "/")) ?? "")
				.query(
					href.components(separatedBy: "?")
						.dropFirst()
						.joined(separator: "?")
						.components(separatedBy: "&")
						.map {
							$0.components(separatedBy: "=")
						}
						.reduce(into: [:]) {
							$0[$1[0]] = $1.dropFirst().joined(separator: "=").removingPercentEncoding
						}
				),
			method: .get
		)
	}

	struct AudioFirstPageRequestOutput: Codable, Hashable {
		public var tracks: [VKAudio]
		public var next: String?
	}
}

extension VK.API.AudioFirstPageRequestOutput: HTMLStringInitable {
	public init(htmlString html: String) throws {
		let document = try SwiftSoup.parse(html.trimmingCharacters(in: .whitespaces))
		let div = try document.getElementsByAttributeValueStarting("class", "AudioPlaylistRoot").first()?.children() ?? Elements()
		tracks = try div.map { try VKAudio(xml: $0) }
		do {
			let element = try document.getElementsByClass("show_more_wrap")
				.first()?
				.children()
				.first()
			?? document.getElementsByClass("show_more AudioSection__showMore--my_audios_block")
				.first()
			
			next = try element?.attr("href")
				.components(separatedBy: "start_from=")
				.last
		} catch {
			next = nil
		}
	}
}

public extension VK.API {

	func audioPageRequest(act: String, offset: Int, from: String? = nil) async throws -> [VKAudio] {
		let input = AudioPageRequestInput(act: act, offset: offset, from: from)
		let output: AudioPageRequestOutput = try await decodableRequest(
			url: baseURL.path("audio").query(from: input),
			method: .post,
			body: multipartData(AudioPageRequestBody()),
			headers: headers(multipart: true)
		)
		return output.data.flatMap(\.list)
	}

	struct AudioPageRequestInput: Codable {
		public var act: String
		public var offset: Int
		public var from: String?
	}

	struct AudioPageRequestBody: Codable {
		public var _ajax = 1
	}

	struct AudioPageRequestOutput: Decodable {

		public var data: [AudioData]

		public enum AudioData: Decodable {
			case unknown
			case plist([VKAudio])

			public var list: [VKAudio] {
				switch self {
				case .unknown: return []
				case let .plist(list): return list
				}
			}

			public init(from decoder: Decoder) throws {
				do {
					let list = try [VKAudio].init(from: decoder)
					self = .plist(list)
				} catch {
					self = .unknown
				}
			}
		}
	}
}

public extension VK.API {

	func list(id: String? = nil, tracks: [VKAudio] = [], block: String? = nil, next: String? = nil) async throws -> [VKAudio] {
		if let block {
			if let next, !next.isEmpty {
				let tr = try await myTracksPageRequest(start_from: next, block: block)
				return try await list(id: id, tracks: tracks + tr.list, block: block, next: next == tr.nextOffset ? nil : tr.nextOffset)
			} else {
				return tracks
			}
		} else {
			let bl = try await audioBlock(id: id)
			let tr = try await audioFirstPageRequest(href: bl.href)
			return try await list(id: id, tracks: tracks + tr.tracks, block: bl.block, next: tr.next)
		}
	}

	func list(playlist: VKPlaylistItemHTML, tracks: [VKAudio] = [], offset: Int? = 0) async throws -> [VKAudio] {
		if let offset {
			let tr = try await audioPageRequest(act: playlist.act ?? "", offset: offset)
			return try await list(playlist: playlist, tracks: tracks + tr, offset: tr.count < 100 || tr.count == 0 ? nil : offset + tr.count)
		} else {
			return tracks
		}
	}
}
