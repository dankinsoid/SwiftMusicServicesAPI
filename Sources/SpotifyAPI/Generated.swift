// Generated using Sourcery 1.8.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Foundation
import SwiftMusicServicesApi
import SwiftHttp
import VDCodable

extension SPAlbum {

  public static func publicInit(
    albumType: String? = nil, 
    artists: [SPArtist]? = nil, 
    availableMarkets: [String]? = nil, 
    copyrights: [SPCopyright]? = nil, 
    externalIds: SPExternalID? = nil, 
    externalUrls: SPExternalURL? = nil, 
    genres: [String]? = nil, 
    href: String? = nil, 
    id: String, 
    images: [SPImage]? = nil, 
    label: String? = nil, 
    name: String, 
    popularity: Int? = nil, 
    releaseDate: String? = nil, 
    releaseDatePrecision: String? = nil, 
    restrictions: SPRestrictions? = nil, 
    tracks: [SPTrack]? = nil, 
    type: String? = nil, 
    uri: String 
  ) -> Self {
    .init(
      albumType: albumType,   
      artists: artists,   
      availableMarkets: availableMarkets,   
      copyrights: copyrights,   
      externalIds: externalIds,   
      externalUrls: externalUrls,   
      genres: genres,   
      href: href,   
      id: id,   
      images: images,   
      label: label,   
      name: name,   
      popularity: popularity,   
      releaseDate: releaseDate,   
      releaseDatePrecision: releaseDatePrecision,   
      restrictions: restrictions,   
      tracks: tracks,   
      type: type,   
      uri: uri   
    )
  }  
}

extension SPAlbumSimplified {

  public static func publicInit(
    albumGroup: String? = nil, 
    albumType: String, 
    artists: [SPArtist]? = nil, 
    availableMarkets: [String], 
    externalUrls: SPExternalURL? = nil, 
    href: String, 
    id: String, 
    images: [SPImage]? = nil, 
    name: String, 
    releaseDate: String, 
    releaseDatePrecision: String, 
    restrictions: SPRestrictions? = nil, 
    type: String, 
    uri: String 
  ) -> Self {
    .init(
      albumGroup: albumGroup,   
      albumType: albumType,   
      artists: artists,   
      availableMarkets: availableMarkets,   
      externalUrls: externalUrls,   
      href: href,   
      id: id,   
      images: images,   
      name: name,   
      releaseDate: releaseDate,   
      releaseDatePrecision: releaseDatePrecision,   
      restrictions: restrictions,   
      type: type,   
      uri: uri   
    )
  }  
}

extension SPArtist {

  public static func publicInit(
    externalUrls: SPExternalURL? = nil, 
    followers: [SPFollower]? = nil, 
    genres: [String]? = nil, 
    href: String? = nil, 
    id: String, 
    images: [SPImage]? = nil, 
    name: String, 
    popularity: Int? = nil, 
    type: String? = nil, 
    uri: String 
  ) -> Self {
    .init(
      externalUrls: externalUrls,   
      followers: followers,   
      genres: genres,   
      href: href,   
      id: id,   
      images: images,   
      name: name,   
      popularity: popularity,   
      type: type,   
      uri: uri   
    )
  }  
}

extension SPArtistSimplified {

  public static func publicInit(
    externalUrls: SPExternalURL? = nil, 
    href: String, 
    id: String, 
    name: String, 
    type: String, 
    uri: String 
  ) -> Self {
    .init(
      externalUrls: externalUrls,   
      href: href,   
      id: id,   
      name: name,   
      type: type,   
      uri: uri   
    )
  }  
}

extension SPAudioFeatures {

  public static func publicInit(
    acousticness: Double, 
    analysisUrl: String, 
    danceability: Double, 
    durationMs: Int, 
    energy: Double, 
    id: String, 
    instrumentalness: Double, 
    key: Int, 
    liveness: Double, 
    loudness: Double, 
    mode: Int, 
    speechiness: Double, 
    tempo: Double, 
    timeSignature: Int, 
    trackHref: String, 
    type: String, 
    uri: String, 
    valence: Double 
  ) -> Self {
    .init(
      acousticness: acousticness,   
      analysisUrl: analysisUrl,   
      danceability: danceability,   
      durationMs: durationMs,   
      energy: energy,   
      id: id,   
      instrumentalness: instrumentalness,   
      key: key,   
      liveness: liveness,   
      loudness: loudness,   
      mode: mode,   
      speechiness: speechiness,   
      tempo: tempo,   
      timeSignature: timeSignature,   
      trackHref: trackHref,   
      type: type,   
      uri: uri,   
      valence: valence   
    )
  }  
}

extension SPCategory {

  public static func publicInit(
    href: String, 
    icons: [SPImage]? = nil, 
    id: String, 
    name: String 
  ) -> Self {
    .init(
      href: href,   
      icons: icons,   
      id: id,   
      name: name   
    )
  }  
}

extension SPContext {

  public static func publicInit(
    type: String, 
    href: String, 
    externalUrls: SPExternalURL? = nil, 
    uri: String 
  ) -> Self {
    .init(
      type: type,   
      href: href,   
      externalUrls: externalUrls,   
      uri: uri   
    )
  }  
}

extension SPCopyright {

  public static func publicInit(
    text: String, 
    type: String 
  ) -> Self {
    .init(
      text: text,   
      type: type   
    )
  }  
}

extension SPCursor {

  public static func publicInit(
    after: String 
  ) -> Self {
    .init(
      after: after   
    )
  }  
}

extension SPEpisode {

  public static func publicInit(
    audioPreviewUrl: String? = nil, 
    description: String, 
    durationMs: Int, 
    explicit: Bool, 
    externalUrls: SPExternalURL? = nil, 
    href: String, 
    id: String, 
    images: [SPImage]? = nil, 
    isExternallyHosted: Bool, 
    isPlayable: Bool? = nil, 
    language: String, 
    languages: [String]? = nil, 
    name: String, 
    releaseDate: String, 
    releaseDatePrecision: String, 
    resumePoint: SPResumePoint, 
    show: SPShow, 
    type: String, 
    uri: String 
  ) -> Self {
    .init(
      audioPreviewUrl: audioPreviewUrl,   
      description: description,   
      durationMs: durationMs,   
      explicit: explicit,   
      externalUrls: externalUrls,   
      href: href,   
      id: id,   
      images: images,   
      isExternallyHosted: isExternallyHosted,   
      isPlayable: isPlayable,   
      language: language,   
      languages: languages,   
      name: name,   
      releaseDate: releaseDate,   
      releaseDatePrecision: releaseDatePrecision,   
      resumePoint: resumePoint,   
      show: show,   
      type: type,   
      uri: uri   
    )
  }  
}

extension SPEpisodeSimplified {

  public static func publicInit(
    audioPreviewUrl: String? = nil, 
    description: String, 
    durationMs: Int, 
    explicit: Bool, 
    externalUrls: SPExternalURL? = nil, 
    href: String, 
    id: String, 
    images: [SPImage]? = nil, 
    isExternallyHosted: Bool, 
    isPlayable: Bool? = nil, 
    language: String? = nil, 
    languages: [String], 
    name: String, 
    releaseDate: String, 
    releaseDatePrecision: String, 
    resumePoint: SPResumePoint, 
    type: String, 
    uri: String 
  ) -> Self {
    .init(
      audioPreviewUrl: audioPreviewUrl,   
      description: description,   
      durationMs: durationMs,   
      explicit: explicit,   
      externalUrls: externalUrls,   
      href: href,   
      id: id,   
      images: images,   
      isExternallyHosted: isExternallyHosted,   
      isPlayable: isPlayable,   
      language: language,   
      languages: languages,   
      name: name,   
      releaseDate: releaseDate,   
      releaseDatePrecision: releaseDatePrecision,   
      resumePoint: resumePoint,   
      type: type,   
      uri: uri   
    )
  }  
}

extension SPError {

  public static func publicInit(
    status: Int, 
    message: String 
  ) -> Self {
    .init(
      status: status,   
      message: message   
    )
  }  
}

extension SPFollower {

  public static func publicInit(
    href: String? = nil, 
    total: Int 
  ) -> Self {
    .init(
      href: href,   
      total: total   
    )
  }  
}

extension SPImage {

  public static func publicInit(
    height: Int? = nil, 
    url: String, 
    width: Int? = nil 
  ) -> Self {
    .init(
      height: height,   
      url: url,   
      width: width   
    )
  }  
}

extension SPPaging {

  public static func publicInit(
    href: String, 
    items: [Item], 
    limit: Int, 
    next: String? = nil, 
    offset: Int, 
    previous: String? = nil, 
    total: Int 
  ) -> Self {
    .init(
      href: href,   
      items: items,   
      limit: limit,   
      next: next,   
      offset: offset,   
      previous: previous,   
      total: total   
    )
  }  
}

extension SPPlayHistory {

  public static func publicInit(
    track: SPTrackSimplified, 
    playedAt: Date, 
    context: SPContext 
  ) -> Self {
    .init(
      track: track,   
      playedAt: playedAt,   
      context: context   
    )
  }  
}

extension SPPlayerError {

  public static func publicInit(
    status: Int, 
    message: String, 
    reason: String 
  ) -> Self {
    .init(
      status: status,   
      message: message,   
      reason: reason   
    )
  }  
}

extension SPPlaylist {

  public static func publicInit(
    collaborative: Bool, 
    description: String? = nil, 
    externalUrls: SPExternalURL? = nil, 
    followers: [SPFollower]? = nil, 
    href: String, 
    id: String, 
    images: [SPImage]? = nil, 
    name: String, 
    owner: SPUser, 
    `public`: Bool? = nil, 
    snapshotId: String, 
    tracks: SPTracks? = nil, 
    type: String, 
    uri: String 
  ) -> Self {
    .init(
      collaborative: collaborative,   
      description: description,   
      externalUrls: externalUrls,   
      followers: followers,   
      href: href,   
      id: id,   
      images: images,   
      name: name,   
      owner: owner,   
      public: `public`,   
      snapshotId: snapshotId,   
      tracks: tracks,   
      type: type,   
      uri: uri   
    )
  }  
}

extension SPPlaylistSimplified {

  public static func publicInit(
    collaborative: Bool, 
    description: String? = nil, 
    externalUrls: SPExternalURL? = nil, 
    href: String, 
    id: String, 
    images: [SPImage]? = nil, 
    name: String, 
    owner: SPUser, 
    `public`: Bool? = nil, 
    snapshotId: String, 
    tracks: SPTracks? = nil, 
    type: String, 
    uri: String 
  ) -> Self {
    .init(
      collaborative: collaborative,   
      description: description,   
      externalUrls: externalUrls,   
      href: href,   
      id: id,   
      images: images,   
      name: name,   
      owner: owner,   
      public: `public`,   
      snapshotId: snapshotId,   
      tracks: tracks,   
      type: type,   
      uri: uri   
    )
  }  
}

extension SPPlaylistTrack {

  public static func publicInit(
    addedAt: Date? = nil, 
    addedBy: SPUser? = nil, 
    isLocal: Bool? = nil, 
    track: SPTrack? = nil 
  ) -> Self {
    .init(
      addedAt: addedAt,   
      addedBy: addedBy,   
      isLocal: isLocal,   
      track: track   
    )
  }  
}

extension SPRecommendations {

  public static func publicInit(
    seeds: [SPRecommendationsSeed]? = nil, 
    tracks: [SPTrackSimplified]? = nil 
  ) -> Self {
    .init(
      seeds: seeds,   
      tracks: tracks   
    )
  }  
}

extension SPRecommendationsSeed {

  public static func publicInit(
    afterFilteringSize: Int, 
    afterRelinkingSize: Int, 
    href: String? = nil, 
    id: String, 
    initialPoolSize: Int, 
    type: String 
  ) -> Self {
    .init(
      afterFilteringSize: afterFilteringSize,   
      afterRelinkingSize: afterRelinkingSize,   
      href: href,   
      id: id,   
      initialPoolSize: initialPoolSize,   
      type: type   
    )
  }  
}

extension SPRestrictions {

  public static func publicInit(
    reason: String 
  ) -> Self {
    .init(
      reason: reason   
    )
  }  
}

extension SPResumePoint {

  public static func publicInit(
    fullyPlayed: Bool, 
    resumePositionMs: Int 
  ) -> Self {
    .init(
      fullyPlayed: fullyPlayed,   
      resumePositionMs: resumePositionMs   
    )
  }  
}

extension SPSavedAlbum {

  public static func publicInit(
    addedAt: Date, 
    album: SPAlbum 
  ) -> Self {
    .init(
      addedAt: addedAt,   
      album: album   
    )
  }  
}

extension SPSavedShow {

  public static func publicInit(
    addedAt: Date, 
    show: SPShow 
  ) -> Self {
    .init(
      addedAt: addedAt,   
      show: show   
    )
  }  
}

extension SPSavedTrack {

  public static func publicInit(
    addedAt: Date? = nil, 
    track: SPTrack 
  ) -> Self {
    .init(
      addedAt: addedAt,   
      track: track   
    )
  }  
}

extension SPShow {

  public static func publicInit(
    availableMarkets: [String], 
    copyrights: [SPCopyright]? = nil, 
    description: String, 
    explicit: Bool, 
    episodes: [SPEpisode]? = nil, 
    externalUrls: SPExternalURL? = nil, 
    href: String, 
    id: String, 
    images: [SPImage]? = nil, 
    isExternallyHosted: Bool? = nil, 
    languages: [String]? = nil, 
    mediaType: String, 
    name: String, 
    publisher: String, 
    type: String, 
    uri: String 
  ) -> Self {
    .init(
      availableMarkets: availableMarkets,   
      copyrights: copyrights,   
      description: description,   
      explicit: explicit,   
      episodes: episodes,   
      externalUrls: externalUrls,   
      href: href,   
      id: id,   
      images: images,   
      isExternallyHosted: isExternallyHosted,   
      languages: languages,   
      mediaType: mediaType,   
      name: name,   
      publisher: publisher,   
      type: type,   
      uri: uri   
    )
  }  
}

extension SPTrack {

  public static func publicInit(
    album: SPAlbum? = nil, 
    artists: [SPArtist]? = nil, 
    availableMarkets: [String]? = nil, 
    discNumber: Int? = nil, 
    durationMs: Int, 
    explicit: Bool? = nil, 
    externalIds: SPExternalID? = nil, 
    externalUrls: SPExternalURL? = nil, 
    href: String? = nil, 
    id: String, 
    isPlayable: Bool? = nil, 
    linkedFrom: SPTrackLink? = nil, 
    restrictions: SPRestrictions? = nil, 
    name: String, 
    popularity: Int? = nil, 
    previewUrl: String? = nil, 
    trackNumber: Int? = nil, 
    type: String? = nil, 
    uri: String, 
    isLocal: Bool? = nil 
  ) -> Self {
    .init(
      album: album,   
      artists: artists,   
      availableMarkets: availableMarkets,   
      discNumber: discNumber,   
      durationMs: durationMs,   
      explicit: explicit,   
      externalIds: externalIds,   
      externalUrls: externalUrls,   
      href: href,   
      id: id,   
      isPlayable: isPlayable,   
      linkedFrom: linkedFrom,   
      restrictions: restrictions,   
      name: name,   
      popularity: popularity,   
      previewUrl: previewUrl,   
      trackNumber: trackNumber,   
      type: type,   
      uri: uri,   
      isLocal: isLocal   
    )
  }  
}

extension SPTrackLink {

  public static func publicInit(
    externalUrls: SPExternalURL? = nil, 
    href: String, 
    id: String, 
    type: String, 
    uri: String 
  ) -> Self {
    .init(
      externalUrls: externalUrls,   
      href: href,   
      id: id,   
      type: type,   
      uri: uri   
    )
  }  
}

extension SPTrackSimplified {

  public static func publicInit(
    artists: [SPArtist]? = nil, 
    availableMarkets: [String]? = nil, 
    discNumber: Int? = nil, 
    durationMs: Int, 
    explicit: Bool? = nil, 
    externalUrls: SPExternalURL? = nil, 
    href: String, 
    id: String, 
    isPlayable: Bool? = nil, 
    linkedFrom: SPTrackLink? = nil, 
    restrictions: SPRestrictions? = nil, 
    name: String, 
    previewUrl: String, 
    trackNumber: Int, 
    type: String, 
    uri: String, 
    isLocal: Bool? = nil 
  ) -> Self {
    .init(
      artists: artists,   
      availableMarkets: availableMarkets,   
      discNumber: discNumber,   
      durationMs: durationMs,   
      explicit: explicit,   
      externalUrls: externalUrls,   
      href: href,   
      id: id,   
      isPlayable: isPlayable,   
      linkedFrom: linkedFrom,   
      restrictions: restrictions,   
      name: name,   
      previewUrl: previewUrl,   
      trackNumber: trackNumber,   
      type: type,   
      uri: uri,   
      isLocal: isLocal   
    )
  }  
}

extension SPTracks {

  public static func publicInit(
    href: String, 
    total: Int 
  ) -> Self {
    .init(
      href: href,   
      total: total   
    )
  }  
}

extension SPUser {

  public static func publicInit(
    displayName: String? = nil, 
    externalUrls: SPExternalURL? = nil, 
    followers: [SPFollower]? = nil, 
    href: String, 
    id: String, 
    images: [SPImage]? = nil, 
    type: String, 
    uri: String 
  ) -> Self {
    .init(
      displayName: displayName,   
      externalUrls: externalUrls,   
      followers: followers,   
      href: href,   
      id: id,   
      images: images,   
      type: type,   
      uri: uri   
    )
  }  
}

extension SPUserPrivate {

  public static func publicInit(
    country: String, 
    displayName: String? = nil, 
    email: String, 
    externalUrls: SPExternalURL? = nil, 
    followers: [SPFollower]? = nil, 
    href: String, 
    id: String, 
    images: [SPImage]? = nil, 
    product: String, 
    type: String, 
    uri: String 
  ) -> Self {
    .init(
      country: country,   
      displayName: displayName,   
      email: email,   
      externalUrls: externalUrls,   
      followers: followers,   
      href: href,   
      id: id,   
      images: images,   
      product: product,   
      type: type,   
      uri: uri   
    )
  }  
}

extension Spotify.API.AddPlaylistOutput {

  public static func publicInit(
    snapshotId: String 
  ) -> Self {
    .init(
      snapshotId: snapshotId   
    )
  }  
}

extension Spotify.API.SavedInput {

  public static func publicInit(
    limit: Int? = 50, 
    offset: Int? = nil, 
    market: String? = nil 
  ) -> Self {
    .init(
      limit: limit,   
      offset: offset,   
      market: market   
    )
  }  
}

extension Spotify.API.SearchOutput {

  public static func publicInit(
    artists: SPPaging<SPArtist>? = nil, 
    albums: SPPaging<SPAlbumSimplified>? = nil, 
    tracks: SPPaging<SPTrack>? = nil, 
    shows: SPPaging<SPShow>? = nil, 
    episodes: SPPaging<SPEpisodeSimplified>? = nil 
  ) -> Self {
    .init(
      artists: artists,   
      albums: albums,   
      tracks: tracks,   
      shows: shows,   
      episodes: episodes   
    )
  }  
}

extension Spotify.API.TracksOutput {

  public static func publicInit(
    tracks: [SPTrack] 
  ) -> Self {
    .init(
      tracks: tracks   
    )
  }  
}

