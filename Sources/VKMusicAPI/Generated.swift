import Foundation
import SimpleCoders
import SwiftMusicServicesApi
import SwiftSoup
import VDCodable

public extension VK.API.AudioPageRequestBody {
	static func publicInit(
		_ajax: Int = 1
	) -> Self {
		.init(
			_ajax: _ajax
		)
	}
}

public extension VK.API.AudioPageRequestInput {
	static func publicInit(
		act: String,
		offset: Int,
		from: String? = nil
	) -> Self {
		.init(
			act: act,
			offset: offset,
			from: from
		)
	}
}

public extension VKActInput {
	static func publicInit(
		act: VKAct? = nil
	) -> Self {
		.init(
			act: act
		)
	}
}

public extension VKAudioInput {
	static func publicInit(
		accessHash: String? = nil,
		hash: String? = nil,
		statusCode: Int? = 200,
		formData: String? = "",
		al: Int = 1,
		claim: Int? = 0,
		isLayer: Int? = nil,
		offset: Int? = nil,
		alId: Int? = nil,
		ownerId: Int? = nil,
		fromId: Int? = nil,
		playlistId: Int? = nil,
		playlistOwnerId: Int? = nil,
		addPlIds: Int? = nil,
		removePlIds: String? = nil,
		isLoadingAll: Int? = nil,
		type: VKAudioInput.ActType? = .playlist,
		section: VKAudioInput.Section? = nil,
		sectionId: String? = nil,
		q: String? = nil,
		audioId: Int? = nil,
		audioOwnerId: Int? = nil,
		trackCode: String? = nil,
		groupId: Int? = nil,
		doAdd: Int? = nil,
		ids: [String]? = nil,
		audios: [String]? = nil,
		cover: Int? = nil,
		title: String? = nil,
		description: String? = nil,
		noDiscover: Int? = nil,
		from: String? = nil,
		__query: String? = nil,
		_ref: String? = nil
	) -> Self {
		.init(
			accessHash: accessHash,
			hash: hash,
			statusCode: statusCode,
			formData: formData,
			al: al,
			claim: claim,
			isLayer: isLayer,
			offset: offset,
			alId: alId,
			ownerId: ownerId,
			fromId: fromId,
			playlistId: playlistId,
			playlistOwnerId: playlistOwnerId,
			addPlIds: addPlIds,
			removePlIds: removePlIds,
			isLoadingAll: isLoadingAll,
			type: type,
			section: section,
			sectionId: sectionId,
			q: q,
			audioId: audioId,
			audioOwnerId: audioOwnerId,
			trackCode: trackCode,
			groupId: groupId,
			doAdd: doAdd,
			ids: ids,
			audios: audios,
			cover: cover,
			title: title,
			description: description,
			noDiscover: noDiscover,
			from: from,
			__query: __query,
			_ref: _ref
		)
	}
}

public extension VKAuthorizeAllParameters {
	static func publicInit(
		act: VKAct = VKAct.login,
		role: String = "al_frame",
		ip_h: String,
		lg_h: String,
		email: String,
		pass: String
	) -> Self {
		.init(
			act: act,
			role: role,
			ip_h: ip_h,
			lg_h: lg_h,
			email: email,
			pass: pass
		)
	}
}

public extension VKAuthorizeParameters {
	static func publicInit(
		pre: VKPreAuthorizeParameters,
		login: String,
		password: String
	) -> Self {
		.init(
			pre: pre,
			login: login,
			password: password
		)
	}
}

public extension VKPayload {
	static func publicInit(
		payload: JSON,
		statsMeta: JSON
	) -> Self {
		.init(
			payload: payload,
			statsMeta: statsMeta
		)
	}
}

public extension VKPlaylist {
	static func publicInit(
		id: Int,
		owner: Int,
		name: String,
		artist: String? = nil,
		imageURL: URL? = nil,
		tracks: [VKAudio]? = nil,
		hash: String,
		editHash: String? = nil
	) -> Self {
		.init(
			id: id,
			owner: owner,
			name: name,
			artist: artist,
			imageURL: imageURL,
			tracks: tracks,
			hash: hash,
			editHash: editHash
		)
	}
}

public extension VKPreAuthorizeParameters {
	static func publicInit(
		ip: String,
		lg: String
	) -> Self {
		.init(
			ip: ip,
			lg: lg
		)
	}
}

public extension VKUser {
	static func publicInit(
		id: Int
	) -> Self {
		.init(
			id: id
		)
	}
}
