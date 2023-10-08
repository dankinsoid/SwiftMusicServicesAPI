import Foundation

public struct VKAudioInput: Encodable {
	public var accessHash: String?
	public var hash: String?
	public var statusCode: Int? = 200
	public var formData: String? = ""
	public var al = 1
	public var claim: Int? = 0
	public var isLayer: Int?
	public var offset: Int?
	public var alId: Int?
	public var ownerId: Int?
	public var fromId: Int?
	public var playlistId: Int?
	public var playlistOwnerId: Int?
	public var addPlIds: Int?
	public var removePlIds: String?
	public var isLoadingAll: Int?
	public var type: ActType? = .playlist
	public var section: Section?
	public var sectionId: String?
	public var q: String?
	public var audioId: Int?
	public var audioOwnerId: Int?
	public var trackCode: String?
	public var groupId: Int?
	public var doAdd: Int?
	public var ids: [String]?
	public var audios: [String]?
	public var cover: Int?
	public var title: String?
	public var description: String?
	public var noDiscover: Int?
	public var from: String?
	public var __query: String?
	public var _ref: String?

	public enum CodingKeys: String, CodingKey, CaseIterable {
		case accessHash = "access_hash", statusCode = "Status Code", formData = "Form Data", playlistId = "playlist_id", ownerId = "owner_id", al, claim, offset, type, section, fromId = "from_id", isLoadingAll = "is_loading_all", q, isLayer = "is_layer", sectionId = "section_id", hash, audioId = "audio_id", trackCode = "track_code", groupId = "group_id", ids, audios = "Audios", cover, description, noDiscover = "no_discover", title, alId = "al_id", __query, audioOwnerId = "audio_owner_id", addPlIds = "add_pl_ids", removePlIds = "remove_pl_ids", from, playlistOwnerId = "playlist_owner_id", doAdd = "do_add"
	}

	public enum ActType: String, Codable, CaseIterable {

		case playlist, playlists, unknown

		public init(from decoder: Decoder) throws {
			self = try Self(rawValue: String(from: decoder)) ?? .unknown
		}
	}

	public enum Section: String, Codable, CaseIterable {
		case playlists, search, unknown

		public init(from decoder: Decoder) throws {
			self = try Self(rawValue: String(from: decoder)) ?? .unknown
		}
	}
}
