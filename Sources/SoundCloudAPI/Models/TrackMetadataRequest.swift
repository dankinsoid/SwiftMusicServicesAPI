import Foundation
import SwiftAPIClient

public struct TrackMetadataRequest: Codable, Equatable {

	public var track: Track?

	public enum CodingKeys: String, CodingKey {

		case track
	}

	public init(
		track: Track? = nil
	) {
		self.track = track
	}

	public struct Track: Codable, Equatable {

		public var commentable: Bool?
		public var description: String?
		public var downloadable: Bool?
		/** who can embed this track "all", "me", or "none" */
		public var embeddableBy: EmbeddableBy?
		public var genre: String?
		public var isrc: String?
		public var labelName: String?
		/** Possible values: no-rights-reserved, all-rights-reserved, cc-by, cc-by-nc, cc-by-nd, cc-by-sa, cc-by-nc-nd, cc-by-nc-sa */
		public var license: License?
		public var permalink: String?
		public var purchaseURL: String?
		public var release: String?
		/** string, formatted as yyyy-mm-dd, representing release date */
		public var releaseDate: String?
		public var sharing: Sharing?
		public var streamable: Bool?
		/** The tag_list property contains a list of tags separated by spaces. Multiword tags are quoted in double quotes. We also support machine tags that follow the pattern NAMESPACE:KEY=VALUE. For example: geo:lat=43.555 camel:size=medium “machine:tag=with space” Machine tags are not revealed to the user on the track pages. */
		public var tagList: String?
		public var title: String?

		public enum CodingKeys: String, CodingKey {

			case commentable
			case description
			case downloadable
			case embeddableBy = "embeddable_by"
			case genre
			case isrc
			case labelName = "label_name"
			case license
			case permalink
			case purchaseURL = "purchase_url"
			case release
			case releaseDate = "release_date"
			case sharing
			case streamable
			case tagList = "tag_list"
			case title
		}

		public init(
			commentable: Bool? = nil,
			description: String? = nil,
			downloadable: Bool? = nil,
			embeddableBy: EmbeddableBy? = nil,
			genre: String? = nil,
			isrc: String? = nil,
			labelName: String? = nil,
			license: License? = nil,
			permalink: String? = nil,
			purchaseURL: String? = nil,
			release: String? = nil,
			releaseDate: String? = nil,
			sharing: Sharing? = nil,
			streamable: Bool? = nil,
			tagList: String? = nil,
			title: String? = nil
		) {
			self.commentable = commentable
			self.description = description
			self.downloadable = downloadable
			self.embeddableBy = embeddableBy
			self.genre = genre
			self.isrc = isrc
			self.labelName = labelName
			self.license = license
			self.permalink = permalink
			self.purchaseURL = purchaseURL
			self.release = release
			self.releaseDate = releaseDate
			self.sharing = sharing
			self.streamable = streamable
			self.tagList = tagList
			self.title = title
		}

		/** who can embed this track "all", "me", or "none" */
		public enum EmbeddableBy: String, Codable, Equatable, CaseIterable, CustomStringConvertible {
			case all
			case me
			case none
			case undecoded

			public init(from decoder: Decoder) throws {
				let container = try decoder.singleValueContainer()
				let rawValue = try container.decode(String.self)
				self = EmbeddableBy(rawValue: rawValue) ?? .undecoded
			}

			public var description: String { rawValue }
		}

		/** Possible values: no-rights-reserved, all-rights-reserved, cc-by, cc-by-nc, cc-by-nd, cc-by-sa, cc-by-nc-nd, cc-by-nc-sa */
		public enum License: String, Codable, Equatable, CaseIterable, CustomStringConvertible {
			case noRightsReserved = "no-rights-reserved"
			case allRightsReserved = "all-rights-reserved"
			case ccBy = "cc-by"
			case ccByNc = "cc-by-nc"
			case ccByNd = "cc-by-nd"
			case ccBySa = "cc-by-sa"
			case ccByNcNd = "cc-by-nc-nd"
			case ccByNcSa = "cc-by-nc-sa"
			case undecoded

			public init(from decoder: Decoder) throws {
				let container = try decoder.singleValueContainer()
				let rawValue = try container.decode(String.self)
				self = License(rawValue: rawValue) ?? .undecoded
			}

			public var description: String { rawValue }
		}

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
	}
}
