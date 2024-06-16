import Foundation
import SimpleCoders
import SwiftAPIClient
import SwiftSoup
import VDCodable

public extension VK.API {
    
    func audioFirstPageRequest(href: String) async throws -> AudioFirstPageRequestOutput {
        try await client
            .xmlHttpRequest
            .path(href, percentEncoded: true)
            .call(.http, as: .htmlInitable)
    }

    func audioFirstPageRequest(id: Int) async throws -> AudioFirstPageRequestOutput {
        try await client("audios\(id)")
            .query(VKAudioPageInput(section: .my))
            .call(.http, as: .htmlInitable)
    }
    
	struct AudioFirstPageRequestOutput: Codable, Hashable {
		public var tracks: [VKAudio]
		public var next: String?
        
        public init(tracks: [VKAudio], next: String? = nil) {
            self.tracks = tracks
            self.next = next
        }
	}
}

extension VK.API.AudioFirstPageRequestOutput: HTMLStringInitable {
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
}

public extension VK.API {

	func audioPageRequest(act: String, offset: Int, from: String? = nil) async throws -> [VKAudio] {
		try await client("audio")
            .xmlHttpRequest
            .query(AudioPageRequestInput(act: act, offset: offset, from: from))
            .method(.post)
            .bodyEncoder(multipartEncoder)
            .body(AudioPageRequestBody())
            .call(.http, as: .decodable(AudioPageRequestOutput.self))
            .data.flatMap(\.list)
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

    func list(limit: Int? = nil) -> VKMyTracks {
        VKMyTracks(limit: limit, api: self)
    }

//	func list(id: Int, tracks: [VKAudio] = [], next: String? = nil) async throws -> [VKAudio] {
//		if let next, !next.isEmpty {
//            let tr = try await myTracksPageRequest(id: id, start_from: next)
//            return try await list(id: id, tracks: tracks + tr.list, next: next == tr.nextOffset ? nil : tr.nextOffset)
//        } else if tracks.isEmpty {
//            let tr = try await audioFirstPageRequest(id: id)
//            return try await list(id: id, tracks: tracks + tr.tracks, next: tr.next)
//        } else {
//            return tracks
//        }
//	}

	func list(playlist: VKPlaylistItemHTML, limit: Int? = nil, offset: Int = 0) -> VKMyPlaylistTracks {
        VKMyPlaylistTracks(limit: limit, offset: offset, playlist: playlist, api: self)
	}
}

public struct VKMyTracks: AsyncSequence {

    public typealias Element = [VKAudio]
    
    let limit: Int?
    let api: VK.API
    
    public func makeAsyncIterator() -> AsyncIterator {
        AsyncIterator(page: self)
    }
    
    public func first() async throws -> [VKAudio] {
        var iterator = makeAsyncIterator()
        return try await iterator.next() ?? []
    }
    
    public struct AsyncIterator: AsyncIteratorProtocol {
        
        let page: VKMyTracks
        var block: String?
        var next: String?
        var didSendFirst = false
        var didSendCount = 0
        var didExceedLimits: Bool {
            page.limit.map { didSendCount >= $0 } ?? false
        }
        
        public mutating func next() async throws -> Element? {
            guard !didExceedLimits else { return nil }
            if let block {
                if let next, !next.isEmpty {
                    let tr = try await page.api.myTracksPageRequest(start_from: next, block: block)
                    self.next = next == tr.nextOffset ? nil : tr.nextOffset
                    didSendCount += tr.list.count
                    return tr.list
                } else {
                    return nil
                }
            } else if !didSendFirst {
                didSendFirst = true
                let bl = try await page.api.audioBlock()
                let tr = try await page.api.audioFirstPageRequest(href: bl.href)
                didSendCount += tr.tracks.count
                block = bl.block
                next = tr.next
                return tr.tracks
            } else {
                return nil
            }
        }
    }
}

public struct VKMyPlaylistTracks: AsyncSequence {
    
    public typealias Element = [VKAudio]
    
    let limit: Int?
    let offset: Int
    let playlist: VKPlaylistItemHTML
    let api: VK.API
    
    public func makeAsyncIterator() -> AsyncIterator {
        AsyncIterator(page: self, offset: offset)
    }
    
    public func first() async throws -> [VKAudio] {
        var iterator = makeAsyncIterator()
        return try await iterator.next() ?? []
    }
    
    public struct AsyncIterator: AsyncIteratorProtocol {

        let page: VKMyPlaylistTracks
        var didSendCount = 0
        var offset: Int?
        var didExceedLimits: Bool {
            page.limit.map { didSendCount >= $0 } ?? false
        }

        public mutating func next() async throws -> Element? {
            guard !didExceedLimits else { return nil }
            if let offset {
                let tr = try await page.api.audioPageRequest(act: page.playlist.act ?? "", offset: offset)
                didSendCount += tr.count
                self.offset = tr.count < 100 || tr.count == 0 ? nil : offset + tr.count
                return tr
            } else {
                return nil
            }
        }
    }
}
