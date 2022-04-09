//
//  File.swift
//  
//
//  Created by Данил Войдилов on 08.04.2022.
//

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
	
	public enum CodingKeys: String, CodingKey {
		case accessHash = "access_hash", statusCode = "Status Code", formData = "Form Data", playlistId = "playlist_id", ownerId = "owner_id", al, claim, offset, type, section, fromId = "from_id", isLoadingAll = "is_loading_all", q, isLayer = "is_layer", sectionId = "section_id", hash, audioId = "audio_id", trackCode = "track_code", groupId = "group_id", ids, audios = "Audios", cover, description, noDiscover = "no_discover", title, alId = "al_id", __query, audioOwnerId = "audio_owner_id", addPlIds = "add_pl_ids", removePlIds = "remove_pl_ids", from, playlistOwnerId = "playlist_owner_id", doAdd = "do_add"
	}
	
	public enum ActType: String, Codable {
		case playlist, playlists
	}
	
	public enum Section: String, Codable {
		case playlists, search
	}
	
	public init(accessHash: String? = nil, hash: String? = nil, statusCode: Int? = 200, formData: String? = "", al: Int = 1, claim: Int? = 0, isLayer: Int? = nil, offset: Int? = nil, alId: Int? = nil, ownerId: Int? = nil, fromId: Int? = nil, playlistId: Int? = nil, playlistOwnerId: Int? = nil, addPlIds: Int? = nil, removePlIds: String? = nil, isLoadingAll: Int? = nil, type: VKAudioInput.ActType? = .playlist, section: VKAudioInput.Section? = nil, sectionId: String? = nil, q: String? = nil, audioId: Int? = nil, audioOwnerId: Int? = nil, trackCode: String? = nil, groupId: Int? = nil, doAdd: Int? = nil, ids: [String]? = nil, audios: [String]? = nil, cover: Int? = nil, title: String? = nil, description: String? = nil, noDiscover: Int? = nil, from: String? = nil, __query: String? = nil, _ref: String? = nil) {
		self.accessHash = accessHash
		self.hash = hash
		self.statusCode = statusCode
		self.formData = formData
		self.al = al
		self.claim = claim
		self.isLayer = isLayer
		self.offset = offset
		self.alId = alId
		self.ownerId = ownerId
		self.fromId = fromId
		self.playlistId = playlistId
		self.playlistOwnerId = playlistOwnerId
		self.addPlIds = addPlIds
		self.removePlIds = removePlIds
		self.isLoadingAll = isLoadingAll
		self.type = type
		self.section = section
		self.sectionId = sectionId
		self.q = q
		self.audioId = audioId
		self.audioOwnerId = audioOwnerId
		self.trackCode = trackCode
		self.groupId = groupId
		self.doAdd = doAdd
		self.ids = ids
		self.audios = audios
		self.cover = cover
		self.title = title
		self.description = description
		self.noDiscover = noDiscover
		self.from = from
		self.__query = __query
		self._ref = _ref
	}
}
