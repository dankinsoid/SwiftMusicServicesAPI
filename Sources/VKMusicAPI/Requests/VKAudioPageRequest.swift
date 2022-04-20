//
// Created by Данил Войдилов on 09.04.2022.
//

import Foundation
import SimpleCoders
import VDCodable
import SwiftSoup
import SwiftHttp

extension VK.API {

	public func audioFirstPageRequest(href: String) async throws -> AudioFirstPageRequestOutput {
		try await request(
				url: baseURL
						.path(href.components(separatedBy: "?").first ?? "")
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

	public struct AudioFirstPageRequestOutput: HTMLStringInitable, Codable, Hashable {
		public var tracks: [VKAudio]
		public var next: String?

		public init(htmlString html: String) throws {
			let document = try SwiftSoup.parse(html.trimmingCharacters(in: .whitespaces))
			let div = try document.getElementsByAttributeValueStarting("class", "AudioPlaylistRoot").first()?.children() ?? Elements()
			tracks = try div.map { try VKAudio(xml: $0) }
			do {
				next = try document.getElementsByClass("show_more AudioSection__showMore--my_audios_block")
						.first()?
						.attr("href")
						.components(separatedBy: "start_from=")
						.last
			} catch {
				next = nil
			}
		}

		public init(tracks: [VKAudio], next: String? = nil) {
			self.tracks = tracks
			self.next = next
		}
	}
}

extension VK.API {

	public func audioPageRequest(act: String, offset: Int, from: String? = nil) async throws -> [VKAudio] {
		let input = AudioPageRequestInput(act: act, offset: offset, from: from)
		let output: AudioPageRequestOutput = try await decodableRequest(
				executor: client.dataTask,
				url: baseURL.path("audio").query(from: input),
				method: .post,
				body: multipartData(AudioPageRequestBody()),
				headers: headers(with: [.xRequestedWith: "XMLHttpRequest"])
		)
		return output.list
	}

	public struct AudioPageRequestInput: Codable {
		public var act: String
		public var offset: Int
		public var from: String?
	}

	public struct AudioPageRequestBody: Codable {
		public var _ajax = 1
	}

	public struct AudioPageRequestOutput: Decodable {
		public var list: [VKAudio]

		public init(from decoder: Decoder) throws {
			let container = try decoder.container(keyedBy: PlainCodingKey.self)
			var unkeyed = try container.nestedUnkeyedContainer(forKey: "data")
			_ = try unkeyed.decode(JSON.self)
			_ = try unkeyed.decode(JSON.self)
			list = try unkeyed.decode([VKAudio].self)
		}
	}
}

extension VK.API {

	public func list(tracks: [VKAudio] = [], block: String? = nil, next: String? = nil) async throws -> [VKAudio] {
		if let block = block {
			if let next = next, !next.isEmpty {
				print("1")
				let tr = try await myTracksPageRequest(start_from: next, block: block)
				print("2", tr.list.count)
				return try await list(tracks: tracks + tr.list, block: block, next: next == tr.nextOffset ? nil : tr.nextOffset)
			} else {
				return tracks
			}
		} else {
			let bl = try await audioBlock()
			let tr = try await audioFirstPageRequest(href: bl.href)
			return try await list(tracks: tracks + tr.tracks, block: bl.block, next: tr.next)
		}
	}

	public func list(playlist: VKPlaylistItemHTML, tracks: [VKAudio] = [], offset: Int? = 0) async throws -> [VKAudio] {
		if let offset = offset {
			let tr = try await audioPageRequest(act: playlist.act ?? "", offset: offset)
			return try await list(playlist: playlist, tracks: tracks + tr, offset: tr.count < 100 || tr.count == 0 ? nil : offset + tr.count)
		} else {
			return tracks
		}
	}
}
