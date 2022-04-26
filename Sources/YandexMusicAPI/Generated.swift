// Generated using Sourcery 1.8.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Foundation
import SimpleCoders
import VDCodable
import SwiftHttp
import SwiftMusicServicesApi

extension E3U {

  public static func publicInit(
    lines: [Line] 
  ) -> Self {
    .init(
      lines: lines   
    )
  }  
}

extension E3U.Formatter {

  public static func publicInit(
    fileStart: String = "#EXTM3U", 
    lineStart: String = "#EXTINF:" 
  ) -> Self {
    .init(
      fileStart: fileStart,   
      lineStart: lineStart   
    )
  }  
}

extension E3U.Line {

  public static func publicInit(
    duration: Int, 
    artist: String, 
    title: String 
  ) -> Self {
    .init(
      duration: duration,   
      artist: artist,   
      title: title   
    )
  }  
}

extension Yandex.Music.API.ImportCodeOutput {

  public static func publicInit(
    status: RawEnum<Status>, 
    tracks: [YMO.Track]? = nil 
  ) -> Self {
    .init(
      status: status,   
      tracks: tracks   
    )
  }  
}

extension Yandex.Music.API.ImportFileOutput {

  public static func publicInit(
    importCode: String 
  ) -> Self {
    .init(
      importCode: importCode   
    )
  }  
}

extension Yandex.Music.API.PassportTokenInput {

  public static func publicInit(
    client_id: String, 
    client_secret: String, 
    grant_type: YM.API.GrantType = .x_token, 
    access_token: String, 
    payment_auth_retpath: String = "yandexmusic://am/payment_auth" 
  ) -> Self {
    .init(
      client_id: client_id,   
      client_secret: client_secret,   
      grant_type: grant_type,   
      access_token: access_token,   
      payment_auth_retpath: payment_auth_retpath   
    )
  }  
}

extension Yandex.Music.API.PlaylistsChangeInput {

  public static func publicInit(
    kind: Int, 
    revision: Int, 
    diff: [Diff], 
    mixed: Bool = false 
  ) -> Self {
    .init(
      kind: kind,   
      revision: revision,   
      diff: diff,   
      mixed: mixed   
    )
  }  
}

extension Yandex.Music.API.PlaylistsChangeInput.Diff {

  public static func publicInit(
    op: YMO.Operation = YMO.Operation.insert, 
    at: Int, 
    tracks: [Track] 
  ) -> Self {
    .init(
      op: op,   
      at: at,   
      tracks: tracks   
    )
  }  
}

extension Yandex.Music.API.PlaylistsChangeInput.Diff.Track {

  public static func publicInit(
    id: String, 
    albumId: String? = nil 
  ) -> Self {
    .init(
      id: id,   
      albumId: albumId   
    )
  }  
}

extension Yandex.Music.API.PlaylistsCreateInput {

  public static func publicInit(
    title: String, 
    visibility: YMO.Visibility = .public 
  ) -> Self {
    .init(
      title: title,   
      visibility: visibility   
    )
  }  
}

extension Yandex.Music.API.SearchOutput {

  public static func publicInit(
    misspellCorrected: Bool? = nil, 
    nocorrect: Bool? = nil, 
    searchRequestId: String? = nil, 
    text: String? = nil, 
    misspellResult: String? = nil, 
    misspellOriginal: String? = nil, 
    best: YMO.BestResult? = nil, 
    albums: YMO.Results<YMO.Album>? = nil, 
    artists: YMO.Results<YMO.Artist>? = nil, 
    playlists: YMO.Results<YMO.Playlist<YMO.TrackShort>>? = nil, 
    tracks: YMO.Results<YMO.Track>? = nil, 
    videos: YMO.Results<YMO.Video>? = nil 
  ) -> Self {
    .init(
      misspellCorrected: misspellCorrected,   
      nocorrect: nocorrect,   
      searchRequestId: searchRequestId,   
      text: text,   
      misspellResult: misspellResult,   
      misspellOriginal: misspellOriginal,   
      best: best,   
      albums: albums,   
      artists: artists,   
      playlists: playlists,   
      tracks: tracks,   
      videos: videos   
    )
  }  
}

extension Yandex.Music.API.TokenBySessionIDInput {

  public static func publicInit(
    client_id: String = "c0ebe342af7d48fbbbfcf2d2eedb8f9e", 
    client_secret: String = "ad0a908f0aa341a182a37ecd75bc319e", 
    grant_type: YM.API.GrantType = .sessionid, 
    host: String = "yandex.com", 
    track_id: String? = nil, 
    cookies: String 
  ) -> Self {
    .init(
      client_id: client_id,   
      client_secret: client_secret,   
      grant_type: grant_type,   
      host: host,   
      track_id: track_id,   
      cookies: cookies   
    )
  }  
}

extension Yandex.Music.API.TokenOutput {

  public static func publicInit(
    tokenType: String? = nil, 
    accessToken: String, 
    expiresIn: Int? = nil, 
    uid: Int? = nil 
  ) -> Self {
    .init(
      tokenType: tokenType,   
      accessToken: accessToken,   
      expiresIn: expiresIn,   
      uid: uid   
    )
  }  
}

extension Yandex.Music.Objects.Account {

  public static func publicInit(
    displayName: String, 
    birthday: String? = nil, 
    secondName: String? = nil, 
    fullName: String? = nil, 
    region: Int? = nil, 
    registeredAt: Date? = nil, 
    serviceAvailable: Bool? = nil, 
    firstName: String? = nil, 
    now: Date? = nil, 
		passportPhones: [YMO.PassportPhone]? = nil,
    hostedUser: Bool? = nil, 
    uid: Int, 
    login: String? = nil 
  ) -> Self {
    .init(
      displayName: displayName,   
      birthday: birthday,   
      secondName: secondName,   
      fullName: fullName,   
      region: region,   
      registeredAt: registeredAt,   
      serviceAvailable: serviceAvailable,   
      firstName: firstName,   
      now: now,   
      passportPhones: passportPhones,   
      hostedUser: hostedUser,   
      uid: uid,   
      login: login   
    )
  }  
}

extension Yandex.Music.Objects.AccountStatus {

  public static func publicInit(
    subeditorLevel: Int? = nil, 
		account: YMO.Account,
		permissions: YMO.Permissions? = nil,
		barBelow: YMO.BarBelow? = nil,
    defaultEmail: String? = nil, 
		plus: YMO.Plus? = nil,
    subeditor: Bool? = nil, 
		subscription: YMO.Subscription
  ) -> Self {
    .init(
      subeditorLevel: subeditorLevel,   
      account: account,   
      permissions: permissions,   
      barBelow: barBelow,   
      defaultEmail: defaultEmail,   
      plus: plus,   
      subeditor: subeditor,   
      subscription: subscription   
    )
  }  
}

extension Yandex.Music.Objects.Album {

  public static func publicInit(
    id: Int, 
    type: String? = nil, 
    storageDir: String? = nil, 
    originalReleaseYear: Int? = nil, 
    year: Int? = nil, 
		artists: [YMO.Artist]? = nil,
    coverUri: String? = nil, 
    trackCount: Int? = nil, 
    genre: String? = nil, 
    available: Bool? = nil, 
    availableForPremiumUsers: Bool? = nil, 
    title: String, 
    regions: [String]? = nil, 
    contentWarning: String? = nil, 
    version: String? = nil, 
		trackPosition: YMO.TrackPosition? = nil
  ) -> Self {
    .init(
      id: id,   
      type: type,   
      storageDir: storageDir,   
      originalReleaseYear: originalReleaseYear,   
      year: year,   
      artists: artists,   
      coverUri: coverUri,   
      trackCount: trackCount,   
      genre: genre,   
      available: available,   
      availableForPremiumUsers: availableForPremiumUsers,   
      title: title,   
      regions: regions,   
      contentWarning: contentWarning,   
      version: version,   
      trackPosition: trackPosition   
    )
  }  
}

extension Yandex.Music.Objects.Artist {

  public static func publicInit(
    id: Int, 
    name: String, 
		cover: YMO.Cover? = nil,
    compose: Bool? = nil, 
    composer: Bool? = nil, 
    various: Bool? = nil, 
		counts: YMO.Counts? = nil,
    genres: [String]? = nil, 
    ticketsAvailable: Bool? = nil, 
    regions: [String]? = nil, 
    decomposed: [JSON]? = nil, 
		popularTracks: [YMO.Track]? = nil
  ) -> Self {
    .init(
      id: id,   
      name: name,   
      cover: cover,   
      compose: compose,   
      composer: composer,   
      various: various,   
      counts: counts,   
      genres: genres,   
      ticketsAvailable: ticketsAvailable,   
      regions: regions,   
      decomposed: decomposed,   
      popularTracks: popularTracks   
    )
  }  
}

extension Yandex.Music.Objects.AutoRenewable {

  public static func publicInit(
    productId: String, 
    expires: Date? = nil, 
    finished: Bool? = nil, 
    vendorHelpUrl: String? = nil, 
    vendor: String? = nil, 
		product: YMO.Product,
    orderId: Int? = nil 
  ) -> Self {
    .init(
      productId: productId,   
      expires: expires,   
      finished: finished,   
      vendorHelpUrl: vendorHelpUrl,   
      vendor: vendor,   
      product: product,   
      orderId: orderId   
    )
  }  
}

extension Yandex.Music.Objects.BarBelow {

  public static func publicInit(
		bgColor: YMO.HEXColor? = nil,
		textColor: YMO.HEXColor? = nil,
    text: String? = nil, 
		button: YMO.Button? = nil
  ) -> Self {
    .init(
      bgColor: bgColor,   
      textColor: textColor,   
      text: text,   
      button: button   
    )
  }  
}

extension Yandex.Music.Objects.Best {

  public static func publicInit(
    id: Int, 
    available: Bool? = nil, 
    availableAsRbt: Bool? = nil, 
    availableForPremiumUsers: Bool? = nil, 
    lyricsAvailable: Bool? = nil, 
    storageDir: String? = nil, 
    durationMs: Int? = nil, 
    explicit: Bool? = nil, 
    title: String? = nil, 
    regions: [String]? = nil, 
		tracks: [YMO.Track]? = nil,
		artists: [YMO.Artist]? = nil,
		albums: [YMO.Album]? = nil,
		playlists: [YMO.Playlist<YMO.TrackShort>]? = nil,
		videos: [YMO.Video]? = nil
  ) -> Self {
    .init(
      id: id,   
      available: available,   
      availableAsRbt: availableAsRbt,   
      availableForPremiumUsers: availableForPremiumUsers,   
      lyricsAvailable: lyricsAvailable,   
      storageDir: storageDir,   
      durationMs: durationMs,   
      explicit: explicit,   
      title: title,   
      regions: regions,   
      tracks: tracks,   
      artists: artists,   
      albums: albums,   
      playlists: playlists,   
      videos: videos   
    )
  }  
}

extension Yandex.Music.Objects.BestResult {

  public static func publicInit(
		type: YMO.SearchType? = nil,
		result: YMO.Best
  ) -> Self {
    .init(
      type: type,   
      result: result   
    )
  }  
}

extension Yandex.Music.Objects.Button {

  public static func publicInit(
		bgColor: YMO.HEXColor? = nil,
		textColor: YMO.HEXColor? = nil,
    text: String? = nil, 
    uri: String? = nil 
  ) -> Self {
    .init(
      bgColor: bgColor,   
      textColor: textColor,   
      text: text,   
      uri: uri   
    )
  }  
}

extension Yandex.Music.Objects.Counts {

  public static func publicInit(
    tracks: Int, 
    tdirectAlbums: Int, 
    talsoAlbumspublic: Int, 
    talsoTracks: Int 
  ) -> Self {
    .init(
      tracks: tracks,   
      tdirectAlbums: tdirectAlbums,   
      talsoAlbumspublic: talsoAlbumspublic,   
      talsoTracks: talsoTracks   
    )
  }  
}

extension Yandex.Music.Objects.Cover {

  public static func publicInit(
    type: String? = nil, 
    uri: String? = nil, 
    custom: Bool? = nil, 
    dir: String? = nil, 
    version: String? = nil, 
    itemsUri: [String]? = nil, 
    prefix: String? = nil 
  ) -> Self {
    .init(
      type: type,   
      uri: uri,   
      custom: custom,   
      dir: dir,   
      version: version,   
      itemsUri: itemsUri,   
      prefix: prefix   
    )
  }  
}

extension Yandex.Music.Objects.DownloadInfo {
	
	public static func publicInit(
		codec: RawEnum<YMO.Codec>? = nil,
    bitrateInKbps: Int? = nil, 
    gain: Bool? = nil,
    preview: Bool? = nil, 
    downloadInfoUrl: String, 
    direct: Bool? = nil 
  ) -> Self {
    .init(
      codec: codec,   
      bitrateInKbps: bitrateInKbps,   
      gain: gain,   
      preview: preview,   
      downloadInfoUrl: downloadInfoUrl,   
      direct: direct   
    )
  }  
}

extension Yandex.Music.Objects.Icon {

  public static func publicInit(
		backgroundColor: YMO.HEXColor,
    imageUrl: String 
  ) -> Self {
    .init(
      backgroundColor: backgroundColor,   
      imageUrl: imageUrl   
    )
  }  
}

extension Yandex.Music.Objects.Library {

  public static func publicInit(
    uid: Int, 
    revision: Int? = nil, 
		tracks: [YMO.TrackShort]? = nil
  ) -> Self {
    .init(
      uid: uid,   
      revision: revision,   
      tracks: tracks   
    )
  }  
}

extension Yandex.Music.Objects.LibraryContainer {

  public static func publicInit(
		library: YMO.Library
  ) -> Self {
    .init(
      library: library   
    )
  }  
}

extension Yandex.Music.Objects.NonAutoRenewableRemainder {

  public static func publicInit(
    days: Int? = nil 
  ) -> Self {
    .init(
      days: days   
    )
  }  
}

extension Yandex.Music.Objects.Owner {

  public static func publicInit(
    uid: Int, 
    login: String? = nil, 
    name: String? = nil, 
    sex: String? = nil, 
    verified: Bool? = nil 
  ) -> Self {
    .init(
      uid: uid,   
      login: login,   
      name: name,   
      sex: sex,   
      verified: verified   
    )
  }  
}

extension Yandex.Music.Objects.PassportPhone {

  public static func publicInit(
    phone: String? = nil 
  ) -> Self {
    .init(
      phone: phone   
    )
  }  
}

extension Yandex.Music.Objects.Permissions {
  public static func publicInit(
    `default`: [String]? = nil,
    values: [String]? = nil, 
    until: Date? = nil 
  ) -> Self {
    .init(
      default: `default`,   
      values: values,   
      until: until   
    )
  }  
}

extension Yandex.Music.Objects.Playlist {

  public static func publicInit(
    uid: Int, 
    kind: Int, 
    trackCount: Int? = nil, 
    title: String, 
		owner: YMO.Owner? = nil,
		cover: YMO.Cover? = nil,
		tags: [YMO.Tag]? = nil,
    regions: [String]? = nil, 
    snapshot: Int? = nil, 
    ogImage: String? = nil, 
    revision: Int? = nil, 
    durationMs: Int? = nil, 
    collective: Bool? = nil, 
    available: Bool? = nil, 
    modified: Date? = nil, 
    created: Date? = nil, 
		visibility: RawEnum<YMO.Visibility>? = nil,
    isBanner: Bool? = nil, 
		prerolls: [YMO.Preroll]? = nil,
    isPremiere: Bool? = nil, 
    tracks: [T]? = nil 
  ) -> Self {
    .init(
      uid: uid,   
      kind: kind,   
      trackCount: trackCount,   
      title: title,   
      owner: owner,   
      cover: cover,   
      tags: tags,   
      regions: regions,   
      snapshot: snapshot,   
      ogImage: ogImage,   
      revision: revision,   
      durationMs: durationMs,   
      collective: collective,   
      available: available,   
      modified: modified,   
      created: created,   
      visibility: visibility,   
      isBanner: isBanner,   
      prerolls: prerolls,   
      isPremiere: isPremiere,   
      tracks: tracks   
    )
  }  
}

extension Yandex.Music.Objects.Plus {

  public static func publicInit(
    hasPlus: Bool, 
    isTutorialCompleted: Bool? = nil 
  ) -> Self {
    .init(
      hasPlus: hasPlus,   
      isTutorialCompleted: isTutorialCompleted   
    )
  }  
}

extension Yandex.Music.Objects.Price {

  public static func publicInit(
    amount: Int, 
    currency: String? = nil 
  ) -> Self {
    .init(
      amount: amount,   
      currency: currency   
    )
  }  
}

extension Yandex.Music.Objects.Product {
	
  public static func publicInit(
    features: [String]? = nil, 
    trialDuration: Int? = nil, 
    productId: String, 
    plus: Bool? = nil, 
    feature: String? = nil,
    trialPeriodDuration: String? = nil,
    type: String? = nil,
    commonPeriodDuration: String? = nil, 
    duration: Int? = nil, 
    debug: Bool? = nil, 
		price: YMO.Price
  ) -> Self {
    .init(
      features: features,   
      trialDuration: trialDuration,   
      productId: productId,   
      plus: plus,   
      feature: feature,   
      trialPeriodDuration: trialPeriodDuration,   
      type: type,   
      commonPeriodDuration: commonPeriodDuration,   
      duration: duration,   
      debug: debug,   
      price: price   
    )
  }  
}

extension Yandex.Music.Objects.Result {

  public static func publicInit(
    result: T, 
		invocationInfo: YMO.InvocationInfo? = nil
  ) -> Self {
    .init(
      result: result,   
      invocationInfo: invocationInfo   
    )
  }  
}

extension Yandex.Music.Objects.Results {

  public static func publicInit(
    total: Int, 
    perPage: Int, 
    order: Int, 
    results: [T] 
  ) -> Self {
    .init(
      total: total,   
      perPage: perPage,   
      order: order,   
      results: results   
    )
  }  
}

extension Yandex.Music.Objects.Subscription {

  public static func publicInit(
    canStartTrial: Bool, 
		nonAutoRenewableRemainder: YMO.NonAutoRenewableRemainder? = nil,
    mcdonalds: Bool? = nil, 
		autoRenewable: [YMO.AutoRenewable]? = nil
  ) -> Self {
    .init(
      canStartTrial: canStartTrial,   
      nonAutoRenewableRemainder: nonAutoRenewableRemainder,   
      mcdonalds: mcdonalds,   
      autoRenewable: autoRenewable   
    )
  }  
}

extension Yandex.Music.Objects.Tag {

  public static func publicInit(
    id: String, 
    value: String 
  ) -> Self {
    .init(
      id: id,   
      value: value   
    )
  }  
}

extension Yandex.Music.Objects.Track {

  public static func publicInit(
    id: Int, 
    available: Bool? = nil, 
    availableAsRbt: Bool? = nil, 
    availableForPremiumUsers: Bool? = nil, 
    lyricsAvailable: Bool? = nil, 
		albums: [YMO.Album]? = nil,
    storageDir: String? = nil, 
    durationMs: Int? = nil, 
    explicit: Bool? = nil, 
    title: String? = nil, 
		artists: [YMO.Artist]? = nil,
    regions: [String]? = nil, 
    version: String? = nil, 
    contentWarning: String? = nil, 
    coverUri: String? = nil 
  ) -> Self {
    .init(
      id: id,   
      available: available,   
      availableAsRbt: availableAsRbt,   
      availableForPremiumUsers: availableForPremiumUsers,   
      lyricsAvailable: lyricsAvailable,   
      albums: albums,   
      storageDir: storageDir,   
      durationMs: durationMs,   
      explicit: explicit,   
      title: title,   
      artists: artists,   
      regions: regions,   
      version: version,   
      contentWarning: contentWarning,   
      coverUri: coverUri   
    )
  }  
}

extension Yandex.Music.Objects.TrackPosition {

  public static func publicInit(
    volume: Int? = nil, 
    index: Int? = nil 
  ) -> Self {
    .init(
      volume: volume,   
      index: index   
    )
  }  
}

extension Yandex.Music.Objects.TrackShort {

  public static func publicInit(
    timestamp: Date? = nil, 
    id: Int, 
    albumId: Int? = nil 
  ) -> Self {
    .init(
      timestamp: timestamp,   
      id: id,   
      albumId: albumId   
    )
  }  
}

extension Yandex.Music.Objects.Video {

  public static func publicInit(
    youtubeUrl: String? = nil, 
    thumbnailUrl: String? = nil, 
    title: String, 
    duration: Int? = nil, 
    text: String? = nil, 
    htmlAutoPlayVideoPlayer: String? = nil, 
    regions: [String]? = nil 
  ) -> Self {
    .init(
      youtubeUrl: youtubeUrl,   
      thumbnailUrl: thumbnailUrl,   
      title: title,   
      duration: duration,   
      text: text,   
      htmlAutoPlayVideoPlayer: htmlAutoPlayVideoPlayer,   
      regions: regions   
    )
  }  
}

extension YandexError {

  public static func publicInit(
    error_description: String? = nil, 
    error: String 
  ) -> Self {
    .init(
      error_description: error_description,   
      error: error   
    )
  }  
}

extension YandexErrorDescription {

  public static func publicInit(
    name: String, 
    message: String 
  ) -> Self {
    .init(
      name: name,   
      message: message   
    )
  }  
}

extension YandexFailure {

  public static func publicInit(
    invocationInfo: YMO.InvocationInfo? = nil, 
    error: YandexErrorDescription 
  ) -> Self {
    .init(
      invocationInfo: invocationInfo,   
      error: error   
    )
  }  
}

