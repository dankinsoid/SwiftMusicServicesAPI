import Foundation
import SwiftAPIClient

public struct CreateUpdatePlaylistRequest: Codable, Equatable {

	public var playlist: Playlist?

	public enum CodingKeys: String, CodingKey {

		case playlist
	}

	public init(
		playlist: Playlist? = nil
	) {
		self.playlist = playlist
	}

	public struct Playlist: Codable, Equatable {

		public var artworkData: File?
		/** Description of the playlist */
		public var description: String?
		/** The European Article Number */
		public var ean: String?
		/** Playlist's genre */
		public var genre: String?
		/** Label name */
		public var labelName: String?
		/** License number */
		public var license: String?
		/** Playlist's permalink */
		public var permalink: String?
		/** Full permalink URL */
		public var permalinkURL: String?
		/** Purchase title */
		public var purchaseTitle: String?
		/** Purchase URL */
		public var purchaseURL: String?
		/** Playlist's release */
		public var release: String?
		/** Release date */
		public var releaseDate: String?
		/** Playlist or album type */
		public var setType: SetType?
		/** public or private */
		public var sharing: Sharing?
		/** A comma-separated list of tags */
		public var tagList: String?
		/** Title of the playlist */
		public var title: String?
		/** List of tracks to add to playlist */
		public var tracks: [Tracks]?

		public enum CodingKeys: String, CodingKey {

			case artworkData = "artwork_data"
			case description
			case ean
			case genre
			case labelName = "label_name"
			case license
			case permalink
			case permalinkURL = "permalink_url"
			case purchaseTitle = "purchase_title"
			case purchaseURL = "purchase_url"
			case release
			case releaseDate = "release_date"
			case setType = "set_type"
			case sharing
			case tagList = "tag_list"
			case title
			case tracks
		}

		public init(
			artworkData: File? = nil,
			description: String? = nil,
			ean: String? = nil,
			genre: String? = nil,
			labelName: String? = nil,
			license: String? = nil,
			permalink: String? = nil,
			permalinkURL: String? = nil,
			purchaseTitle: String? = nil,
			purchaseURL: String? = nil,
			release: String? = nil,
			releaseDate: String? = nil,
			setType: SetType? = nil,
			sharing: Sharing? = nil,
			tagList: String? = nil,
			title: String? = nil,
			tracks: [Tracks]? = nil
		) {
			self.artworkData = artworkData
			self.description = description
			self.ean = ean
			self.genre = genre
			self.labelName = labelName
			self.license = license
			self.permalink = permalink
			self.permalinkURL = permalinkURL
			self.purchaseTitle = purchaseTitle
			self.purchaseURL = purchaseURL
			self.release = release
			self.releaseDate = releaseDate
			self.setType = setType
			self.sharing = sharing
			self.tagList = tagList
			self.title = title
			self.tracks = tracks
		}

		/** Playlist or album type */
		public enum SetType: String, Codable, Equatable, CaseIterable, CustomStringConvertible {
			case album
			case playlist
			case undecoded

			public init(from decoder: Decoder) throws {
				let container = try decoder.singleValueContainer()
				let rawValue = try container.decode(String.self)
				self = SetType(rawValue: rawValue) ?? .undecoded
			}

			public var description: String { rawValue }
		}

		/** public or private */
		public enum Sharing: String, Codable, Equatable, CaseIterable, CustomStringConvertible {
			case `public`
			case `private`
			case undecoded

			public init(from decoder: Decoder) throws {
				let container = try decoder.singleValueContainer()
				let rawValue = try container.decode(String.self)
				self = Sharing(rawValue: rawValue) ?? .undecoded
			}

			public var description: String { rawValue }
		}

		public struct Tracks: Codable, Equatable {

			/** SoundCloud track id */
			public var id: String

			public enum CodingKeys: String, CodingKey {

				case id
			}

			public init(
				id: String
			) {
				self.id = id
			}
		}
	}
}
