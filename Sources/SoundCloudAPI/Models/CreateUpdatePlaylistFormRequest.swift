import Foundation
import SwiftAPIClient

public struct CreateUpdatePlaylistFormRequest: Codable, Equatable {

	public var playlistartworkData: File?
	public var playlistdescription: String?
	public var playlistean: String?
	public var playlistgenre: String?
	public var playlistlabelName: String?
	public var playlistlicense: String?
	public var playlistpermalink: String?
	public var playlistpermalinkUrl: String?
	public var playlistpurchaseTitle: String?
	public var playlistpurchaseUrl: String?
	public var playlistrelease: String?
	public var playlistreleaseDate: String?
	public var playlistsetType: PlaylistsetType?
	public var playlistsharing: Playlistsharing?
	public var playlisttagList: String?
	public var playlisttitle: String?
	/** To pass multiple tracks, pass multiple comma-separated values, e.g. -F "playlist[tracks][][id]=111,222" */
	public var playlisttracksid: String?

	public enum CodingKeys: String, CodingKey {

		case playlistartworkData = "playlist[artwork_data]"
		case playlistdescription = "playlist[description]"
		case playlistean = "playlist[ean]"
		case playlistgenre = "playlist[genre]"
		case playlistlabelName = "playlist[label_name]"
		case playlistlicense = "playlist[license]"
		case playlistpermalink = "playlist[permalink]"
		case playlistpermalinkUrl = "playlist[permalink_url]"
		case playlistpurchaseTitle = "playlist[purchase_title]"
		case playlistpurchaseUrl = "playlist[purchase_url]"
		case playlistrelease = "playlist[release]"
		case playlistreleaseDate = "playlist[release_date]"
		case playlistsetType = "playlist[set_type]"
		case playlistsharing = "playlist[sharing]"
		case playlisttagList = "playlist[tag_list]"
		case playlisttitle = "playlist[title]"
		case playlisttracksid = "playlist[tracks][][id]"
	}

	public init(
		playlistartworkData: File? = nil,
		playlistdescription: String? = nil,
		playlistean: String? = nil,
		playlistgenre: String? = nil,
		playlistlabelName: String? = nil,
		playlistlicense: String? = nil,
		playlistpermalink: String? = nil,
		playlistpermalinkUrl: String? = nil,
		playlistpurchaseTitle: String? = nil,
		playlistpurchaseUrl: String? = nil,
		playlistrelease: String? = nil,
		playlistreleaseDate: String? = nil,
		playlistsetType: PlaylistsetType? = nil,
		playlistsharing: Playlistsharing? = nil,
		playlisttagList: String? = nil,
		playlisttitle: String? = nil,
		playlisttracksid: String? = nil
	) {
		self.playlistartworkData = playlistartworkData
		self.playlistdescription = playlistdescription
		self.playlistean = playlistean
		self.playlistgenre = playlistgenre
		self.playlistlabelName = playlistlabelName
		self.playlistlicense = playlistlicense
		self.playlistpermalink = playlistpermalink
		self.playlistpermalinkUrl = playlistpermalinkUrl
		self.playlistpurchaseTitle = playlistpurchaseTitle
		self.playlistpurchaseUrl = playlistpurchaseUrl
		self.playlistrelease = playlistrelease
		self.playlistreleaseDate = playlistreleaseDate
		self.playlistsetType = playlistsetType
		self.playlistsharing = playlistsharing
		self.playlisttagList = playlisttagList
		self.playlisttitle = playlisttitle
		self.playlisttracksid = playlisttracksid
	}

	public enum PlaylistsetType: String, Codable, Equatable, CaseIterable, CustomStringConvertible {
		case album
		case playlist
		case undecoded

		public init(from decoder: Decoder) throws {
			let container = try decoder.singleValueContainer()
			let rawValue = try container.decode(String.self)
			self = PlaylistsetType(rawValue: rawValue) ?? .undecoded
		}

		public var description: String { rawValue }
	}

	public enum Playlistsharing: String, Codable, Equatable, CaseIterable, CustomStringConvertible {
		case `public`
		case `private`
		case undecoded

		public init(from decoder: Decoder) throws {
			let container = try decoder.singleValueContainer()
			let rawValue = try container.decode(String.self)
			self = Playlistsharing(rawValue: rawValue) ?? .undecoded
		}

		public var description: String { rawValue }
	}
}
