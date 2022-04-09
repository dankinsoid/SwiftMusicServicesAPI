//
//  File.swift
//  
//
//  Created by Данил Войдилов on 08.04.2022.
//

import Foundation
import SwiftSoup
import VDCodable
import HTMLEntities
import SimpleCoders

public struct VKAudio: Codable, Hashable, Identifiable {
	public var id: Int
	public var ownerId: Int?
	public var title: String
	public var artist: String
	public var duration: Int		//seconds
	public var imageURL: URL?
	public var ids: String?
	public var addHash: String?
	public var trackCode: String?
	
	public init(id: Int, ownerId: Int? = nil, title: String, artist: String, duration: Int, imageURL: URL? = nil, ids: String? = nil, addHash: String? = nil, trackCode: String? = nil) {
		self.id = id
		self.ownerId = ownerId
		self.title = title
		self.artist = artist
		self.duration = duration
		self.imageURL = imageURL
		self.ids = ids
		self.addHash = addHash
		self.trackCode = trackCode
	}
	
	public init(from decoder: Decoder) throws {
		do {
			var container = try decoder.unkeyedContainer()
			let _id = try container.decode(Int.self)
			id = _id
			let id2 = try container.decode(Int.self)
			ownerId = id2
			for _ in 2..<3 {
				_ = try container.decode(JSON.self)
			}
			title = try container.decode(String.self).htmlUnescape()
			artist = try container.decode(String.self).htmlUnescape()
			duration = try container.decode(Int.self)
			for _ in 6..<13 {
				_ = try container.decode(JSON.self)
			}
			let str = try container.decode(String.self)
			addHash = str.components(separatedBy: "//").first
			let id3 = try str
				.components(separatedBy: "//")
				.dropFirst()
				.joined(separator: "_")
				.replacingOccurrences(of: "/", with: "")
			ids = "\(id2)_\(_id)_\(id3)"
			imageURL = try? URL(string: container.decode(String.self).components(separatedBy: ",").last ?? "")
			for _ in 15..<20 {
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
		}
	}
	
	public static func ==(_ lhs: VKAudio, _ rhs: VKAudio) -> Bool {
		return lhs.id == rhs.id
	}
}

extension VKAudio: XMLInitable {

	public init(xml: SwiftSoup.Element) throws {
		let dataId = try xml.attr("data-id")
		guard let int = dataId.components(separatedBy: "_").last.flatMap({ Int($0) }) else {
			throw DecodingError.keyNotFound(PlainCodingKey("id"), DecodingError.Context(codingPath: [], debugDescription: "", underlyingError: nil))
		}
		id = int
		ownerId = dataId.components(separatedBy: "_").first.flatMap({ Int($0) })
		title = try xml.getElementsByClass("ai_title").first()?.text() ?? ""
		artist = try xml.getElementsByClass("ai_artist").first()?.text() ?? ""
		duration = try Int(xml.getElementsByClass("ai_dur").first()?.attr("data-dur") ?? "") ?? 0
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