import Foundation
import SwiftAPIClient
import SimpleCoders

public extension Yandex.Music.API {

	func tracks(ids: [String], withPositions: Bool = true) async throws -> [YMO.Track] {
        try await withThrowingTaskGroup(of: [YMO.Track].self, returning: [YMO.Track].self) { [self] group in
            var i = 0
            let maxSize = 100
            while i < ids.count {
                let chunk = Array(ids[i..<min(i + maxSize, ids.count)])
                i += maxSize
                group.addTask { [self] in
                    try await client("tracks")
                        .query(TracksInput(ids: chunk, withPositions: withPositions))
                        .post()
                }
            }
            return try await group.collect()
        }
	}

	struct TracksInput: Encodable {

		public var ids: [String]
		public var withPositions = true

		enum CodingKeys: String, CodingKey, CaseIterable {

			case ids = "track-ids", withPositions = "with-positions"
		}

		public init(ids: [String], withPositions: Bool = true) {
			self.ids = ids
			self.withPositions = withPositions
		}
	}
}

public extension Yandex.Music.API {

	func tracksDownloadInfo(id: String) async throws -> [YMO.DownloadInfo] {
        try await client("tracks", id, "download-info").get()
	}
}

extension Yandex.Music.API {

	public func fileURL(xmlURL: URL, codec: YMO.Codec, trackId: String, uid: Int) async throws -> URL {
        let xml = try await client.url(xmlURL).call(.http, as: .string)
		let host = try getXML(at: "host", xml: xml)
		let path = try getXML(at: "path", xml: xml)
		let ts = try getXML(at: "ts", xml: xml)
		let s = try getXML(at: "s", xml: xml)
		//            let region = getXML(at: "region", xml: xml).flatMap(Int.init)
		var base = URL(string: "https://" + host) ?? Yandex.Music.API.baseURL
		base.appendPathComponent("get-\(codec.rawValue)/\(MD5(String(path.dropFirst()) + s))/\(ts)\(path)")
		let parameters = Parameters(trackId: trackId, uid: uid)
		return try URLQueryEncoder().encode(parameters, for: base)
	}
    
    public struct TrackIDs: AsyncSequence {
    
        public typealias Element = [YMO.Track]
    
        let ids: [String]
        let withPositions: Bool
        let api: YM.API
        
        public func makeAsyncIterator() -> AsyncIterator {
            AsyncIterator(base: self)
        }
        
        public func first() async throws -> [YMO.Track] {
            var iterator = makeAsyncIterator()
            return try await iterator.next() ?? []
        }
        
        public struct AsyncIterator: AsyncIteratorProtocol {
            let base: TrackIDs
            
            public mutating func next() async throws -> [YMO.Track]? {
                nil
            }
        }
    }

	private func getXML(at key: String, xml: String) throws -> String {
		let all = xml.components(separatedBy: "<\(key)>")
		guard !all.isEmpty,
		      let result = all.dropFirst()
		      .compactMap({ $0.components(separatedBy: "</\(key)>").first })
		      .first
		else {
			throw DecodingError.keyNotFound(
                PlainCodingKey(key),
                DecodingError.Context(codingPath: [], debugDescription: "")
            )
		}
		return result
	}

	private struct Parameters: Encodable {
		let trackId: String
		let uid: Int
		let from = "mobile"
		let play = false

		private enum CodingKeys: String, CodingKey, CaseIterable {
			case trackId = "track-id", uid, from, play
		}
	}
}

public struct InvalidUrl: Error { public init() {} }
