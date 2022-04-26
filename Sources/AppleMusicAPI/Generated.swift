// Generated using Sourcery 1.8.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import VDCodable
import SwiftMusicServicesApi
import SwiftHttp
import Foundation

extension AppleMusic.API.AddPlaylistInput.Attributes {

  public static func publicInit(
    name: String, 
    description: String 
  ) -> Self {
    .init(
      name: name,   
      description: description   
    )
  }  
}

extension AppleMusic.API.AddPlaylistInput.Relationships {

  public static func publicInit(
    tracks: AppleMusic.Objects.Response<AppleMusic.Objects.ShortItem> 
  ) -> Self {
    .init(
      tracks: tracks   
    )
  }  
}

extension AppleMusic.API.GetMyPlaylistsInput {

  public static func publicInit(
    limit: Int = 100, 
    include: [AppleMusic.Objects.Include]? = nil 
  ) -> Self {
    .init(
      limit: limit,   
      include: include   
    )
  }  
}

extension AppleMusic.API.GetPlaylistsInput {

  public static func publicInit(
    ids: [String] 
  ) -> Self {
    .init(
      ids: ids   
    )
  }  
}

extension AppleMusic.API.LibraryPlaylistInput {

  public static func publicInit(
    include: [AppleMusic.Objects.Include]? = [.tracks, .catalog] 
  ) -> Self {
    .init(
      include: include   
    )
  }  
}

extension AppleMusic.API.MySongsInput {

  public static func publicInit(
    include: [AppleMusic.Objects.Include]? = nil, 
    limit: Int, 
    offset: Int 
  ) -> Self {
    .init(
      include: include,   
      limit: limit,   
      offset: offset   
    )
  }  
}

extension AppleMusic.API.SearchInput {

  public static func publicInit(
    term: String, 
    limit: Int = 15, 
    offset: Int = 0, 
    types: [AppleMusic.Types] 
  ) -> Self {
    .init(
      term: term,   
      limit: limit,   
      offset: offset,   
      types: types   
    )
  }  
}

extension AppleMusic.API.SearchResults {

  public static func publicInit(
    results: AppleMusic.API.SearchResults.Songs 
  ) -> Self {
    .init(
      results: results   
    )
  }  
}

extension AppleMusic.API.SearchResults.Songs {

  public static func publicInit(
    songs: [AppleMusic.Objects.Response<AppleMusic.Objects.Item>]? = nil 
  ) -> Self {
    .init(
      songs: songs   
    )
  }  
}

extension AppleMusic.API.SongsByISRCInput {

  public static func publicInit(
    isrcs: [String] 
  ) -> Self {
    .init(
      isrcs: isrcs   
    )
  }  
}

extension AppleMusic.API.SongsInput {

  public static func publicInit(
    ids: [String] 
  ) -> Self {
    .init(
      ids: ids   
    )
  }  
}

