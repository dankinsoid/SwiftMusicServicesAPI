import Foundation
import SwiftAPIClient
import VDCodable

public extension Amazon.Music.BrowserAPI {

	func showHome() async throws -> Amazon.Objects.Layout {
		try await musicClient("showHome").post()
	}

	func showLibraryHome() async throws -> Amazon.Objects.Layout {
		try await musicClient("showLibraryHome").post()
	}

	func showLibraryPlaylist(id: String) async throws -> Amazon.Objects.Layout {
		try await musicClient("showLibraryPlaylist")
			.amazonBody { body, _ in
				body.set(id, for: "id")
			}
			.post()
	}
}

public extension Amazon.Objects.Layout {

	var asPlaylists: [Amazon.Music.Playlist] {
		methods.flatMap {
			$0.template?.widgets?.flatMap {
				$0.items?.compactMap { item -> Amazon.Music.Playlist? in
					if let link = item.primaryLink?.deeplink,
					   link.trimmingCharacters(in: ["/"]).hasPrefix("my/playlists/"),
					   let id = link.components(separatedBy: ["/"]).last
					{
						return Amazon.Music.Playlist(
							id: id,
							title: item.imageAltText?.text ?? item.text?.text ?? item.primaryText?.text ?? "Amazon Playlist",
							image: item.image,
							deeplink: item.primaryLink?.deeplink
						)
					} else {
						return nil
					}
				} ?? []
			} ?? []
		}
	}

	var asTracks: [Amazon.Music.Track] {
		methods.flatMap {
			$0.template?.widgets?.flatMap {
				$0.items?.compactMap { (item: Amazon.Objects.Widget.Item) -> Amazon.Music.Track? in
					guard let id = item.id ?? item.primaryLink?.deeplink.components(separatedBy: ["="]).last else { return nil }
					return Amazon.Music.Track(
						id: id,
						title: item.primaryText?.text ?? item.text?.text ?? "Amazon Track",
						duration: item.secondaryText3?.text.convertDurationToSeconds,
						image: item.image,
						artists: item.secondaryText1.map {
							[
								Amazon.Music.Artist(
									name: $0.text,
									deeplink: item.secondaryText1Link?.deeplink
								),
							]
						} ?? [],
						album: item.secondaryText2.map {
							Amazon.Music.Album(
								title: $0.text,
								deeplink: item.secondaryText2Link?.deeplink
							)
						},
						deeplink: item.primaryLink?.deeplink
					)
				} ?? []
			} ?? []
		}
	}
}

private extension String {

	var convertDurationToSeconds: Int? {
		let components = components(separatedBy: ":").reversed().prefix(3)
		guard !components.isEmpty else { return nil }
		var seconds = 0
		for (index, component) in components.enumerated() {
			if let value = Int(component.trimmingCharacters(in: .decimalDigits.inverted)) {
				seconds += value * Int(pow(60.0, Double(index)))
			} else {
				return nil
			}
		}
		return seconds
	}
}

public extension Amazon.Music {

	struct Playlist: Equatable, Identifiable, Sendable, Codable {

		public var id: String
		public var title: String
		public var image: URL?
		public var deeplink: String?

		public init(id: String, title: String, image: URL? = nil, deeplink: String? = nil) {
			self.id = id
			self.title = title
			self.image = image
			self.deeplink = deeplink
		}
	}

	struct Track {

		public var id: String
		public var title: String
		public var duration: Int?
		public var image: URL?
		public var artists: [Artist]
		public var album: Album?
		public var deeplink: String?
	}

	struct Artist: Equatable, Sendable, Codable {

		public var name: String
		public var deeplink: String?

		public init(name: String, deeplink: String? = nil) {
			self.name = name
			self.deeplink = deeplink
		}
	}

	struct Album: Equatable, Sendable, Codable {

		public var title: String
		public var deeplink: String?

		public init(title: String, deeplink: String? = nil) {
			self.title = title
			self.deeplink = deeplink
		}
	}
}
