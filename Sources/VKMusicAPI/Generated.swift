// Generated using Sourcery 1.8.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import VDCodable
import SwiftSoup
import MultipartFormDataKit
import HTMLEntities
import SwiftMusicServicesApi
import SimpleCoders
import Foundation
import SwiftHttp

extension VK.API.AudioPageRequestBody {

  public static func publicInit(
    _ajax: Int = 1 
  ) -> Self {
    .init(
      _ajax: _ajax   
    )
  }  
}

extension VK.API.AudioPageRequestInput {

  public static func publicInit(
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

extension VK.API.MyTracksPageRequestInput {

  public static func publicInit(
    act: VKAct, 
    block: String, 
    start_from: String 
  ) -> Self {
    .init(
      act: act,   
      block: block,   
      start_from: start_from   
    )
  }  
}

extension VK.API.MyTracksPageRequestInputBody {

  public static func publicInit(
    _ajax: Int = 1 
  ) -> Self {
    .init(
      _ajax: _ajax   
    )
  }  
}

extension VKActInput {

  public static func publicInit(
    act: VKAct? = nil 
  ) -> Self {
    .init(
      act: act   
    )
  }  
}

extension VKAudioInput {

  public static func publicInit(
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

extension VKAudioPageInput {

  public static func publicInit(
    section: VKAudioPageInput.Section? = nil, 
    block: VKAudioPageInput.Block? = nil, 
    z: String? = nil 
  ) -> Self {
    .init(
      section: section,   
      block: block,   
      z: z   
    )
  }  
}

extension VKAuthorizeAllParameters {

  public static func publicInit(
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

extension VKAuthorizeParameters {

  public static func publicInit(
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

extension VKPayload {

  public static func publicInit(
    payload: JSON, 
    statsMeta: JSON 
  ) -> Self {
    .init(
      payload: payload,   
      statsMeta: statsMeta   
    )
  }  
}

extension VKPlaylist {

  public static func publicInit(
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

extension VKPreAuthorizeParameters {

  public static func publicInit(
    ip: String, 
    lg: String 
  ) -> Self {
    .init(
      ip: ip,   
      lg: lg   
    )
  }  
}

extension VKUser {

  public static func publicInit(
    id: Int 
  ) -> Self {
    .init(
      id: id   
    )
  }  
}

