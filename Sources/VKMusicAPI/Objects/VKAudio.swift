import Foundation
import SimpleCoders
import SwiftAPIClient
import SwiftSoup
import VDCodable

public struct VKAudio: Encodable, Hashable, Identifiable {
	public var id: Int
	public var ownerId: Int?
	public var title: String
	public var artist: String
	public var duration: Int // seconds
	public var imageURL: URL?
	public var ids: String?
	public var addHash: String?
	public var hashes: [String]
	public var trackCode: String?

	public static func == (_ lhs: VKAudio, _ rhs: VKAudio) -> Bool {
		lhs.id == rhs.id
	}
}

extension VKAudio: Decodable {
	public init(from decoder: Decoder) throws {
		do {
			var container = try decoder.unkeyedContainer()
			let _id = try container.decode(Int.self)
			id = _id
			let id2 = try container.decode(Int.self)
			ownerId = id2
			for _ in 2 ..< 3 {
				_ = try container.decode(JSON.self)
			}
			title = try Entities.unescape(container.decode(String.self))
			artist = try Entities.unescape(container.decode(String.self))
			duration = try container.decode(Int.self)
			for _ in 6 ..< 13 {
				_ = try container.decode(JSON.self)
			}
			let str = try container.decode(String.self)
			hashes = str.components(separatedBy: "/")
			addHash = hashes.first
			if hashes.count > 5 {
				ids = "\(id2)_\(_id)_\(hashes[2])_\(hashes[5])"
			}
			imageURL = try? URL(string: container.decode(String.self).components(separatedBy: ",").last ?? "")
			for _ in 15 ..< 20 {
				_ = try container.decode(JSON.self)
			}
			trackCode = try? container.decode(String.self)
		} catch {
			let container = try decoder.container(keyedBy: CodingKeys.self)
			id = try container.decode(Int.self, forKey: .id)
			ownerId = try container.decode(Int.self, forKey: .ownerId)
			title = try container.decode(String.self, forKey: .title)
			artist = try container.decode(String.self, forKey: .artist)
			duration = try container.decode(Int.self, forKey: .duration)
			imageURL = try container.decodeIfPresent(URL.self, forKey: .imageURL)
			ids = try container.decodeIfPresent(String.self, forKey: .ids)
			trackCode = try container.decodeIfPresent(String.self, forKey: .trackCode)
			addHash = try container.decodeIfPresent(String.self, forKey: .addHash)
			hashes = try container.decodeIfPresent([String].self, forKey: .hashes) ?? []
		}
	}
}

extension VKAudio: XMLInitable {
	public init(xml: SwiftSoup.Element) throws {
		let dataId = try xml.attr("data-id")
		guard let int = dataId.components(separatedBy: "_").last.flatMap({ Int($0) }) else {
			throw DecodingError.keyNotFound(SimpleCoders.PlainCodingKey("id"), DecodingError.Context(codingPath: [], debugDescription: "", underlyingError: nil))
		}
		id = int
		ownerId = dataId.components(separatedBy: "_").first.flatMap { Int($0) }
		title = try xml.getElementsByClass("ai_title").first()?.text() ?? ""
		artist = try xml.getElementsByClass("ai_artist").first()?.text() ?? ""
		duration = try Int(xml.getElementsByClass("ai_dur").first()?.attr("data-dur") ?? "") ?? 0
		hashes = []
		do {
			let style = try xml.getElementsByClass("ai_play").first()?.attr("style")
			imageURL = (style?.components(separatedBy: "url(").dropFirst().first?.components(separatedBy: ")").first).flatMap {
				URL(string: $0)
			}
		} catch {
			imageURL = nil
		}
	}
}

extension VKAudio: Mockable {
	public static let mock = VKAudio(
		id: 123_456_789,
		ownerId: 987_654_321,
		title: "Mock Track",
		artist: "Mock Artist",
		duration: 240,
		imageURL: URL(string: "https://example.com/image.jpg"),
		ids: "987654321_123456789_hash1_hash2",
		addHash: "mock_hash",
		hashes: ["mock_hash", "hash2", "hash3", "hash4", "hash5", "hash6"],
		trackCode: "mock_track_code"
	)
}
