import Foundation
import SwiftAPIClient

public struct TrackDataRequest: Codable, Equatable {

	public var trackartworkData: File?
	public var trackassetData: File?
	public var trackcommentable: Bool?
	public var trackdescription: String?
	public var trackdownloadable: Bool?
	/** who can embed this track "all", "me", or "none" */
	public var trackembeddableBy: TrackembeddableBy?
	public var trackgenre: String?
	public var trackisrc: String?
	public var tracklabelName: String?
	/** Possible values: no-rights-reserved, all-rights-reserved, cc-by, cc-by-nc, cc-by-nd, cc-by-sa, cc-by-nc-nd, cc-by-nc-sa */
	public var tracklicense: Tracklicense?
	public var trackpermalink: String?
	public var trackpurchaseUrl: String?
	public var trackrelease: String?
	/** string, formatted as yyyy-mm-dd, representing release date */
	public var trackreleaseDate: String?
	public var tracksharing: Tracksharing?
	public var trackstreamable: Bool?
	/** The tag_list property contains a list of tags separated by spaces. Multiword tags are quoted in double quotes. We also support machine tags that follow the pattern NAMESPACE:KEY=VALUE. For example: geo:lat=43.555 camel:size=medium “machine:tag=with space” Machine tags are not revealed to the user on the track pages. */
	public var tracktagList: String?
	public var tracktitle: String?

	public enum CodingKeys: String, CodingKey {

		case trackartworkData = "track[artwork_data]"
		case trackassetData = "track[asset_data]"
		case trackcommentable = "track[commentable]"
		case trackdescription = "track[description]"
		case trackdownloadable = "track[downloadable]"
		case trackembeddableBy = "track[embeddable_by]"
		case trackgenre = "track[genre]"
		case trackisrc = "track[isrc]"
		case tracklabelName = "track[label_name]"
		case tracklicense = "track[license]"
		case trackpermalink = "track[permalink]"
		case trackpurchaseUrl = "track[purchase_url]"
		case trackrelease = "track[release]"
		case trackreleaseDate = "track[release_date]"
		case tracksharing = "track[sharing]"
		case trackstreamable = "track[streamable]"
		case tracktagList = "track[tag_list]"
		case tracktitle = "track[title]"
	}

	public init(
		trackartworkData: File? = nil,
		trackassetData: File? = nil,
		trackcommentable: Bool? = nil,
		trackdescription: String? = nil,
		trackdownloadable: Bool? = nil,
		trackembeddableBy: TrackembeddableBy? = nil,
		trackgenre: String? = nil,
		trackisrc: String? = nil,
		tracklabelName: String? = nil,
		tracklicense: Tracklicense? = nil,
		trackpermalink: String? = nil,
		trackpurchaseUrl: String? = nil,
		trackrelease: String? = nil,
		trackreleaseDate: String? = nil,
		tracksharing: Tracksharing? = nil,
		trackstreamable: Bool? = nil,
		tracktagList: String? = nil,
		tracktitle: String? = nil
	) {
		self.trackartworkData = trackartworkData
		self.trackassetData = trackassetData
		self.trackcommentable = trackcommentable
		self.trackdescription = trackdescription
		self.trackdownloadable = trackdownloadable
		self.trackembeddableBy = trackembeddableBy
		self.trackgenre = trackgenre
		self.trackisrc = trackisrc
		self.tracklabelName = tracklabelName
		self.tracklicense = tracklicense
		self.trackpermalink = trackpermalink
		self.trackpurchaseUrl = trackpurchaseUrl
		self.trackrelease = trackrelease
		self.trackreleaseDate = trackreleaseDate
		self.tracksharing = tracksharing
		self.trackstreamable = trackstreamable
		self.tracktagList = tracktagList
		self.tracktitle = tracktitle
	}

	/** who can embed this track "all", "me", or "none" */
	public enum TrackembeddableBy: String, Codable, Equatable, CaseIterable, CustomStringConvertible {
		case all
		case me
		case none
		case undecoded

		public init(from decoder: Decoder) throws {
			let container = try decoder.singleValueContainer()
			let rawValue = try container.decode(String.self)
			self = TrackembeddableBy(rawValue: rawValue) ?? .undecoded
		}

		public var description: String { rawValue }
	}

	/** Possible values: no-rights-reserved, all-rights-reserved, cc-by, cc-by-nc, cc-by-nd, cc-by-sa, cc-by-nc-nd, cc-by-nc-sa */
	public enum Tracklicense: String, Codable, Equatable, CaseIterable, CustomStringConvertible {
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
			self = Tracklicense(rawValue: rawValue) ?? .undecoded
		}

		public var description: String { rawValue }
	}

	public enum Tracksharing: String, Codable, Equatable, CaseIterable, CustomStringConvertible {
		case `public`
		case `private`
		case undecoded

		public init(from decoder: Decoder) throws {
			let container = try decoder.singleValueContainer()
			let rawValue = try container.decode(String.self)
			self = Tracksharing(rawValue: rawValue) ?? .undecoded
		}

		public var description: String { rawValue }
	}
}
