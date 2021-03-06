//
//  AddAlbom.swift
//  MusicImport
//
//  Created by Данил Войдилов on 03.07.2019.
//  Copyright © 2019 Данил Войдилов. All rights reserved.
//

import Foundation
import SwiftHttp
import VDCodable

extension AppleMusic.API {

	public func addPlaylist(name: String, description: String, tracks: [AppleMusic.Objects.ShortItem]) -> AsyncThrowingStream<[AppleMusic.Objects.Item], Error> {
		addPlaylist(input: AddPlaylistInput(name: name, description: description, tracks: tracks))
	}

	public func addPlaylist(input: AddPlaylistInput) -> AsyncThrowingStream<[AppleMusic.Objects.Item], Error> {
		dataRequest(
				url: baseURL.path("me", "library", "playlists"),
				method: .post,
				body: input
		)
	}

	public struct AddPlaylistInput: Encodable {
		public var attributes: Attributes
		public var relationships: Relationships

		public init(name: String, description: String, tracks: [AppleMusic.Objects.ShortItem]) {
			attributes = Attributes(name: name, description: description)
			relationships = Relationships(tracks: .init(data: tracks))
		}

		public init(name: String, description: String, trackIDs: Set<String>) {
			attributes = Attributes(name: name, description: description)
			relationships = Relationships(tracks: .init(data: trackIDs.map({ AppleMusic.Objects.ShortItem(id: $0, type: .songs) })))
		}

		public init(attributes: AppleMusic.API.AddPlaylistInput.Attributes, relationships: AppleMusic.API.AddPlaylistInput.Relationships) {
			self.attributes = attributes
			self.relationships = relationships
		}
		
		public struct Relationships: Codable {
			public var tracks: AppleMusic.Objects.Response<AppleMusic.Objects.ShortItem>
		}

		public struct Attributes: Encodable {
			public var name: String
			public var description: String
		}
	}
}

extension AppleMusic.API {

	public func addTracks(playlistID id: String, tracks: AppleMusic.Objects.Response<AppleMusic.Objects.Item>) async throws {
		_ = try await encodableRequest(
				executor: client.dataTask,
				url: baseURL.path("me", "library", "playlists", id, "tracks"),
				method: .post,
				headers: headers(),
				body: tracks
		)
	}
}

extension AppleMusic.API {
	
	public func getTracks(playlistID id: String) -> AsyncThrowingStream<[AppleMusic.Objects.Item], Error> {
		dataRequest(
				url: baseURL.path("me", "library", "playlists", id, "tracks")
		)
	}
}

extension AppleMusic.API {
	
	public func getMyPlaylists(limit: Int = 100, include: [AppleMusic.Objects.Include]? = nil) throws -> AsyncThrowingStream<[AppleMusic.Objects.Item], Error> {
		try dataRequest(
				url: baseURL.path("me", "library", "playlists").query(from: GetMyPlaylistsInput(limit: limit, include: include))
		)
	}

	public struct GetMyPlaylistsInput: Encodable {
		public var limit = 100
		public var include: [AppleMusic.Objects.Include]?
	}
}

extension AppleMusic.API {
	
	public func libraryPlaylist(playlistID id: String, include: [AppleMusic.Objects.Include]? = [.tracks, .catalog]) throws -> AsyncThrowingStream<[AppleMusic.Objects.Item], Error> {
		try dataRequest(
				url: baseURL.path("me", "library", "playlists", id).query(from: LibraryPlaylistInput(include: include))
		)
	}

	public struct LibraryPlaylistInput: Encodable {
		public var include: [AppleMusic.Objects.Include]? = [.tracks, .catalog]
	}
}

extension AppleMusic.API {

	public func getPlaylists(ids: [String], storefront: String) throws -> AsyncThrowingStream<[AppleMusic.Objects.Item], Error> {
		try dataRequest(
				url: baseURL.path("catalog", storefront, "playlists").query(from: GetPlaylistsInput(ids: ids))
		)
	}

	public struct GetPlaylistsInput: Encodable {
		public var ids: [String]
	}
}
