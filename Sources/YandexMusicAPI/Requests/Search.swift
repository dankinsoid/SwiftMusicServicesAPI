//
//  Search.swift
//  YandexAPI
//
//  Created by Daniil on 08.11.2019.
//  Copyright © 2019 Daniil. All rights reserved.
//

import Foundation
import SwiftHttp
import VDCodable

extension Yandex.Music.API {

    public func search(text: String, nocorrect: Bool = false, type: YMO.SearchType = .track, page: Int, playlistInBest: Bool = false) async throws -> SearchOutput {
        try await request(
            url: baseURL.path("search").query(
                from: SearchInput(text: text, nocorrect: nocorrect, type: type, page: page, playlistInBest: playlistInBest),
                encoder: queryEncoder
            ),
            method: .get
        )
    }

    public struct SearchInput: Encodable {
        public var text: String
        public var nocorrect: Bool = false
        public var type: Yandex.Music.Objects.SearchType = .track
        public var page: Int
        public var playlistInBest: Bool = false

        public init(text: String, nocorrect: Bool = false, type: YMO.SearchType = .track, page: Int, playlistInBest: Bool = false) {
            self.text = text
            self.nocorrect = nocorrect
            self.type = type
            self.page = page
            self.playlistInBest = playlistInBest
        }

        public enum CodingKeys: String, CodingKey, CaseIterable {
            case text, nocorrect, type, page, playlistInBest = "playlist-in-best"
        }
    }

    public struct SearchOutput: Decodable {
        public var misspellCorrected: Bool?
        public var nocorrect: Bool?
        public var searchRequestId: String?
        public var text: String?
        public var misspellResult: String?
        public var misspellOriginal: String?

        public var best: YMO.BestResult?
        public var albums: YMO.Results<YMO.Album>?
        public var artists: YMO.Results<YMO.Artist>?
        public var playlists: YMO.Results<YMO.Playlist<YMO.TrackShort>>?
        public var tracks: YMO.Results<YMO.Track>?
        public var videos: YMO.Results<YMO.Video>?
    }
}
