//
//  SPAPIPlaylistts.swift
//  MusicImport
//
//  Created by Daniil on 25.07.2020.
//  Copyright © 2020 Данил Войдилов. All rights reserved.
//

import Foundation
import SwiftHttp

extension Spotify.API {
    
    ///https://developer.spotify.com/documentation/web-api/reference/playlists/get-a-list-of-current-users-playlists/
    public func playlists(
        token: String,
        limit: Int? = nil,
        offset: Int? = nil
    ) throws -> AsyncThrowingStream<[SPPlaylistSimplified], Error>  {
        try pagingRequest(
            output: SPPaging<SPPlaylistSimplified>.self,
            executor: client.dataTask,
            url: baseURL.path("me", "playlists").query(from: PlaylistsInput(limit: limit, offset: offset)),
            method: .get,
            parameters: (),
            headers: headers()
        )
    }

    public struct PlaylistsInput: Encodable {
        public var limit: Int?
        public var offset: Int?

        public init(limit: Int? = nil, offset: Int? = nil) {
            self.limit = limit
            self.offset = offset
        }
    }

    public func playlist(
        id: String,
        input: PlaylistInput
    ) async throws -> SPPlaylist {
        try await decodableRequest(
            executor: client.dataTask,
            url: baseURL.path("playlists", id).query(from: input),
            method: .get,
            headers: headers()
        )
    }

    public struct PlaylistInput: Encodable {
        public var fields: [String]?
        public var market: String?
        public var additionalTypes: String?

        public init(fields: [String]? = nil, market: String? = nil, additionalTypes: String? = nil) {
            self.fields = fields
            self.market = market
            self.additionalTypes = additionalTypes
        }
    }
    
    ///https://developer.spotify.com/documentation/web-api/reference/playlists/add-tracks-to-playlist/
    @discardableResult
    public func addPlaylist(
        token: String,
        id: String,
        input: AddPlaylistInput
    ) async throws -> AddPlaylistOutput {
        try await codableRequest(
            executor: client.dataTask,
            url: baseURL.path("playlists", id, "tracks"),
            method: .post,
            headers: headers(),
            body: input
        )
    }

    public struct AddPlaylistInput: Encodable {
        public var uris: [String]?
        public var position: Int?

        public init(uris: [String]? = nil, position: Int? = nil) {
            self.uris = uris
            self.position = position
        }
    }

    public struct AddPlaylistOutput: Decodable {
        public var snapshotId: String
    }

    ///https://developer.spotify.com/documentation/web-api/reference/playlists/add-tracks-to-playlist/
    public func createPlaylist(
        token: String,
        userId: String,
        input: CreatePlaylistInput
    ) async throws -> SPPlaylist {
        try await codableRequest(
            executor: client.dataTask,
            url: baseURL.path("users", userId, "playlists"),
            method: .post,
            headers: headers(with: [.key(.contentType): "application/json"]),
            body: input
        )
    }

    public struct CreatePlaylistInput: Encodable {
        ///Required. The name for the new playlist, for example "Your Coolest Playlist" . This name does not need to be unique; a user may have several playlists with the same name.
        public var name: String
        ///Optional. Defaults to true . If true the playlist will be public, if false it will be private. To be able to create private playlists, the user must have granted the playlist-modify-private scope .
        public var `public`: Bool?
        ///Optional. Defaults to false . If true the playlist will be collaborative. Note that to create a collaborative playlist you must also set public to false . To create collaborative playlists you must have granted playlist-modify-private and playlist-modify-public scopes .
        public var collaborative: Bool?
        ///Optional. value for playlist description as displayed in Spotify Clients and in the Web API.
        public var description: String?

        public init(name: String, isPublic: Bool? = nil, collaborative: Bool? = nil, description: String? = nil) {
            self.name = name
            self.public = isPublic
            self.collaborative = collaborative
            self.description = description
        }
    }
}
