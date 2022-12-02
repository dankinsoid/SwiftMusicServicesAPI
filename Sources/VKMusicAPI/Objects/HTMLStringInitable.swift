import Foundation
import VDCodable

public protocol HTMLStringInitable {
	init(htmlString html: String) throws
}

extension String: HTMLStringInitable {
	public init(htmlString: String) {
		self = htmlString
	}
}

extension JSON: HTMLStringInitable {
	public init(htmlString html: String) throws {
		self = .string(html)
	}
}

extension [VKPlaylist]: HTMLStringInitable {
	public init(htmlString html: String) throws {
		var components = html.components(separatedBy: "audio_pl_item2")
		components.removeFirst()
		self = components.map {
			let imageURL = URL(string: $0.firstBetween("style=\\\"background-image: url('", and: "')") ?? "")
			var id = -1
			var owner = -1
			var hash = ""
			let name = $0.firstBetween("domPN(this))\\\">", and: "<") ?? ""
			let artist: String? = $0.firstBetween("audio_pl_snippet__artist_link", and: "<")?
				.components(separatedBy: ">").last ?? ""
			let ids = $0.components(separatedBy: "AudioUtils.showAudioPlaylist(")
			if ids.count > 1 {
				let comps = ids[1].components(separatedBy: ", ")
				if comps.count > 3 {
					id = Int(comps[1]) ?? -1
					owner = Int(comps[0]) ?? -1
					hash = comps[2].replacingOccurrences(of: "'", with: "")
				}
			}
			return VKPlaylist(id: id, owner: owner, name: name, artist: artist, imageURL: imageURL, tracks: [], hash: hash)
		}
	}

	public func asPlaylists() -> [VKPlaylist] {
		self
	}
}

extension String {
	func firstBetween(_ first: String, and second: String) -> String? {
		let prefixes = components(separatedBy: first)
		if prefixes.count > 1 {
			return prefixes[1].components(separatedBy: second).first
		}
		return nil
	}
}
